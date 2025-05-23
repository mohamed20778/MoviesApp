import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies_app/core/services/cached_service.dart';
import 'package:movies_app/core/services/movie_service.dart';
import 'package:movies_app/core/services/push_notification_service.dart';
import 'package:movies_app/core/utils/constants.dart';
import 'package:movies_app/cubits/get_movie_cubit/get_movie_cubit.dart';
import 'package:movies_app/cubits/observers/my_observer.dart';
import 'package:movies_app/firebase_options.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/routing/router_generator.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
  }
}

void main() async {
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = MyObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieModelAdapter());
  await Hive.deleteBoxFromDisk(ApiConstants.kmovieBox);
  await Hive.openBox<MovieModel>(ApiConstants.kmovieBox);
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      print("Firebase initialized successfully");
    }
  } catch (e) {
    if (kDebugMode) {
      print("Firebase initialization failed: $e");
    }
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await RouterGenerator.initDeepLinks();
  await PushNotificationService().configNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:
          (context, child) => BlocProvider(
            create:
                (context) => GetMovieCubit(
                  movieService: MovieService(),
                  cachedService: CachedService(),
                ),
            child: MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: MaterialApp.router(
                routerConfig: RouterGenerator.mainRoutingOurApp,
                debugShowCheckedModeBanner: false,
                themeMode: ThemeMode.dark,
                darkTheme: ThemeData(brightness: Brightness.dark),
                title: 'Movies App',
              ),
            ),
          ),
    );
  }
}
