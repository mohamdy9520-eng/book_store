import 'package:book_store/authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/routes/routes.dart';
import '../../../../gen/assets.gen.dart';
import '../../../search_screen/cubit/search_cubit.dart';
import '../../../search_screen/ui/search_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (route) => false,);
              },
              child: Icon(Icons.arrow_back_ios),
            ),

            SizedBox(width: 10.w),
            Assets.images.splash.image(
              width: 100.w,
            ),

            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => SearchCubit(),
                      child: const SearchScreen(),
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(
                "assets/icons/search-normal.svg",
                width: 24.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}