import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/routing/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      context.push(AppRoutes.homeScreen);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset('assets/images/splash_screen.png')),
    );
  }
}
