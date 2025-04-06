import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/services/details_service.dart';
import 'package:movies_app/core/theme/app_style.dart';
import 'package:movies_app/cubits/get_details_cubit/get_details_cubit.dart';
import 'package:movies_app/routing/app_routes.dart';
import 'package:movies_app/view/home_screen.dart';
import 'package:movies_app/view/details_screen.dart';
import 'package:movies_app/view/splash_screen.dart';

class RouterGenerator {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter mainRoutingOurApp = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) {
      final uri = state.uri;
      debugPrint('Handling URI: $uri');

      if (uri.scheme == 'movieapptask' && uri.host == 'open') {
        return AppRoutes.homeScreen;
      }

      if (uri.scheme == 'https' && uri.host == 'mohamed20778.github.io') {
        return AppRoutes.homeScreen;
      }

      return null;
    },
    initialLocation: AppRoutes.splashScreen,
    errorBuilder:
        (context, state) => Scaffold(
          body: Center(
            child: Text(
              "This route doesn't exist",
              style: AppStyle.headlinestyle1(),
            ),
          ),
        ),
    routes: [
      GoRoute(
        name: AppRoutes.splashScreen,
        path: AppRoutes.splashScreen,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: const SplashScreen()),
      ),
      GoRoute(
        name: AppRoutes.homeScreen,
        path: AppRoutes.homeScreen,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: const HomeScreen()),
      ),
      GoRoute(
        name: AppRoutes.movieDetails,
        path: '${AppRoutes.movieDetails}:id',
        pageBuilder: (context, state) {
          final movieId = int.tryParse(state.pathParameters['id']!);
          if (movieId == null) {
            return MaterialPage(key: state.pageKey, child: const HomeScreen());
          }
          return MaterialPage(
            key: state.pageKey,
            child: BlocProvider(
              create:
                  (context) =>
                      GetDetailsCubit(detailsService: MovdetailsService()),
              child: MovieDetailsPage(movieId: movieId),
            ),
          );
        },
      ),
    ],
  );

  static void handleDeepLink(Uri uri) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (uri.scheme == 'movieapptask' && uri.host == 'open') {
        if (kDebugMode) {
          print('Received deep link, navigating to home screen');
        }
        final pathSegments = uri.pathSegments;
        if (pathSegments.length == 2 && pathSegments[0] == 'movie') {
          final movieId = int.tryParse(pathSegments[1]);
          if (movieId != null) {
            if (kDebugMode) {
              print('Navigating to movie details screen with ID: $movieId');
            }
            mainRoutingOurApp.go('${AppRoutes.movieDetails}$movieId');
            return;
          }
        }
        mainRoutingOurApp.go(AppRoutes.homeScreen);
      } else if (uri.scheme == 'https' &&
          uri.host == 'mohamed20778.github.io') {
        if (kDebugMode) {
          print('Received GitHub deep link, navigating to home screen');
        }
        mainRoutingOurApp.go(AppRoutes.homeScreen);
      }
    });
  }

  static Future<void> initDeepLinks() async {
    const platform = MethodChannel('app.channel/deeplink');

    try {
      final initialLink = await platform.invokeMethod<String>('getInitialLink');
      if (initialLink != null) {
        handleDeepLink(Uri.parse(initialLink));
      }

      platform.setMethodCallHandler((call) async {
        if (call.method == 'onNewLink') {
          handleDeepLink(Uri.parse(call.arguments as String));
        }
      });
    } on PlatformException catch (e) {
      debugPrint('Failed to initialize deep links: ${e.message}');
    }
  }
}
