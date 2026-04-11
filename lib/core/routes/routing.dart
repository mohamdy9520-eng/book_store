import 'package:book_store/core/routes/routes.dart';
import 'package:book_store/features/bottom_nav_bar/ui/bottom_nav_bar_screen.dart';
import 'package:book_store/features/search_screen/cubit/search_cubit.dart';
import 'package:book_store/features/search_screen/ui/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        return MaterialPageRoute(builder: (_) => BottomNavBarScreen());

      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SearchCubit(),
            child: SearchScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
          const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          ),
        );
    }
  }
}