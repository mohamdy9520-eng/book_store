import 'package:book_store/core/theme/app_text_style.dart';
import 'package:book_store/features/welcome/ui/widgets/login_screen.dart';
import 'package:book_store/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(22.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(20.w),
                child: SvgPicture.asset(
                  'assets/images/Successmark.svg',
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 20.h),

              Text(
                LocaleKeys.Password_Changed.tr(),
                style: AppTextStyle.PasswordChanged,
              ),

              SizedBox(height: 10.h),

              Text(
                LocaleKeys.Congrats.tr(),
                style: AppTextStyle.repassword,
              ),

              SizedBox(height: 30.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFbfa45e),
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed:(){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen())
                    );
                  },
                  child: Text(
                    LocaleKeys.Back_to_Login.tr(),
                    style: AppTextStyle.code,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}