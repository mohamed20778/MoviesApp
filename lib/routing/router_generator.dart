import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/theme/app_style.dart';
import 'package:movies_app/routing/app_routes.dart';
import 'package:movies_app/view/home_screen.dart';
import 'package:movies_app/view/movie_details.dart';

class RouterGenerator {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static late final GoRouter mainRoutingOurApp = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (BuildContext context, GoRouterState state) {
      final uri = state.uri;
      debugPrint('Handling URI: $uri'); // Debug logging

      if (uri.scheme == 'movieapptask' && uri.host == 'open') {
        return AppRoutes.homeScreen;
      } else if (uri.host == 'mohamed20778.github.io') {
        return AppRoutes.homeScreen;
      }
      return null;
    },
    initialLocation: AppRoutes.homeScreen,
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
        name: AppRoutes.homeScreen,
        path: AppRoutes.homeScreen,
        pageBuilder:
            (context, state) =>
                MaterialPage(key: state.pageKey, child: const HomeScreen()),
      ),
      GoRoute(
        name: AppRoutes.movieDetails,
        path: AppRoutes.movieDetails,
        pageBuilder:
            (context, state) => MaterialPage(
              key: state.pageKey,
              child: const MovDetailsScreen(),
            ),
      ),
    ],
  );

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
    } on Exception catch (e) {
      debugPrint('Deep link error: ${e.toString()}');
    }
  }

  static void handleDeepLink(Uri uri) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = rootNavigatorKey.currentContext;
      if (context == null) {
        debugPrint('Context is null, cannot handle deep link');
        return;
      }

      debugPrint('Processing deep link: $uri');

      if (uri.scheme == 'movieapptask' && uri.host == 'open') {
        mainRoutingOurApp.go(AppRoutes.homeScreen);
      } else if (uri.host == 'mohamed20778.github.io') {
        mainRoutingOurApp.go(AppRoutes.homeScreen);
      }
    });
  }
}
