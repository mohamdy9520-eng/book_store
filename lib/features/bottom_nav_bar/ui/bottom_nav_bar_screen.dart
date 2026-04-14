import 'package:book_store/core/routes/routes.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/features/cart/ui/cart_screen.dart';
import 'package:book_store/features/home/cubit/home_cubit.dart';
import 'package:book_store/features/home/ui/home_screen.dart';
import 'package:book_store/features/profile/ui/profile_screen.dart';
import 'package:book_store/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../wishlist/ui/wishlist_screen.dart';


class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();

}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int activeIndex=0;

  List<Widget>screens=[
    BlocProvider(
  create: (context) => HomeCubit()..getSlider()..getBestSeller(),
  child: HomeScreen(),
),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon:SvgPicture.asset(Assets.icons.home,
        colorFilter: ColorFilter.mode(activeIndex==0?AppColors.primaryColor:Colors.grey, BlendMode.srcIn)),label:"Home"),
        BottomNavigationBarItem(icon:SvgPicture.asset(Assets.icons.bookmark,
    colorFilter: ColorFilter.mode(activeIndex==0?AppColors.primaryColor:Colors.grey, BlendMode.srcIn)),label:"WishList"),
        BottomNavigationBarItem(icon:SvgPicture.asset(Assets.icons.frame15),label:"Cart"),
        BottomNavigationBarItem(icon:SvgPicture.asset(Assets.icons.profile),label:"Profile")
      ],
      currentIndex: activeIndex,
      onTap: (index){
        setState(() {
          activeIndex=index;
        });
      },
          selectedItemColor:AppColors.primaryColor,
      type: BottomNavigationBarType.fixed),

      body:SafeArea(child: Padding(
        padding:EdgeInsets.symmetric(horizontal:12.w),
        child: screens[activeIndex],
      ))
    );
  }
}
