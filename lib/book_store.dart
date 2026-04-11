import 'package:book_store/core/helper/app_constants.dart';
import 'package:book_store/features/bottom_nav_bar/ui/bottom_nav_bar_screen.dart';
import 'package:book_store/features/home/ui/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'authentication/welcome_screen.dart';
import 'features/search_screen/ui/search_screen.dart';

class BookStore extends StatelessWidget {
  const BookStore({super.key});

  @override
  Widget build(BuildContext context) {
    SingleChildScrollView;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        routes: {
          "searchScreen": (context) => SearchScreen(),
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: "DM",
          scaffoldBackgroundColor: Colors.white
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute:(v){

        },
          home: startScreen(),
      ),
    );
  }

  Widget startScreen(){
    if(AppConstants.token==null){
      return WelcomeScreen();
    }else{
      return BottomNavBarScreen();
    }
  }
}
