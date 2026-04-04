import 'package:book_store/core/routes/routes.dart';
import 'package:book_store/features/bottom_nav_bar/ui/bottom_nav_bar_screen.dart';
import 'package:flutter/material.dart';

import '../../authentication/login_screen.dart';
import '../../authentication/signup_screen.dart';


class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => SignupScreen(),
        );

      case Routes.bottomNavBarScreen:
        return MaterialPageRoute(builder: (_)=>BottomNavBarScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          ),
        );
    }
  }
}