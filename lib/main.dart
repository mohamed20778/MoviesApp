import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/routing/router_generator.dart';
import 'package:movies_app/view/home_screen.dart';

// 1. Declare navigatorKey as final at the top level
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RouterGenerator.initDeepLinks();

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
          (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.noScaling, // Disable system text scaling
            ),
            child: MaterialApp.router(
              routerConfig: RouterGenerator.mainRoutingOurApp,

              themeMode: ThemeMode.dark,
              darkTheme: ThemeData(brightness: Brightness.dark),
              title: 'Movies App',
            ),
          ),
    );
  }
}
