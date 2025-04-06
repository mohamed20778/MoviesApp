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
          final movieId = int.tryParse(state.pathParameters['id'] ?? '');
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
      final context = rootNavigatorKey.currentContext;
      if (context == null) return;

      debugPrint('Processing deep link: $uri');

      if (uri.scheme == 'movieapptask' && uri.host == 'open') {
        final pathSegments = uri.pathSegments;
        if (pathSegments.length == 2 && pathSegments[0] == 'movie') {
          final movieId = int.tryParse(pathSegments[1]);
          if (movieId != null) {
            mainRoutingOurApp.go('${AppRoutes.movieDetails}$movieId');
            return;
          }
        }
        mainRoutingOurApp.go(AppRoutes.homeScreen);
      } else if (uri.scheme == 'https' &&
          uri.host == 'mohamed20778.github.io') {
        // Only handle if path is exactly /deeplink/movie/123
        final pathSegments = uri.pathSegments;
        if (pathSegments.length == 3 &&
            pathSegments[0] == 'deeplink' &&
            pathSegments[1] == 'movie') {
          final movieId = int.tryParse(pathSegments[2]);
          if (movieId != null) {
            mainRoutingOurApp.go('${AppRoutes.movieDetails}$movieId');
            return;
          }
        }
        // All other cases go to home
        mainRoutingOurApp.go(AppRoutes.homeScreen);
      }
    });
  }

  static Future<void> initDeepLinks() async {
    const platform = MethodChannel('app.channel/deeplink');

    try {
      // Get the initial link if the app was opened from a deep link
      final initialLink = await platform.invokeMethod<String>('getInitialLink');
      if (initialLink != null) {
        handleDeepLink(Uri.parse(initialLink));
      }

      // Set up a handler for incoming links while the app is running
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
