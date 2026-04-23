import 'package:book_store/core/helper/app_constants.dart';
import 'package:book_store/features/bottom_nav_bar/ui/bottom_nav_bar_screen.dart';
import 'package:book_store/features/home/ui/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'authentication/welcome_screen.dart';
import 'authentication/login_screen.dart';
import 'features/search_screen/ui/search_screen.dart';

class BookStore extends StatelessWidget {
  final Widget startWidget;

  const BookStore({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        routes: {
          "login": (context) => LoginScreen(),
          "home": (context) => HomeScreen(),
          "searchScreen": (context) => SearchScreen(),
          "bottomNavBar": (context) => BottomNavBarScreen(),
        },

        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "login":
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case "home":
              return MaterialPageRoute(builder: (_) => HomeScreen());
          }
          return null;
        },

        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,

        theme: ThemeData(
          fontFamily: "DM",
          scaffoldBackgroundColor: Colors.white,
        ),

        home: startWidget,
      ),
    );
  }
}