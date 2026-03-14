import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/gen/fonts.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final String text;
  final TextEditingController? controller;

  const AppButton({
    super.key,
    this.backgroundColor,
    this.onTap,
    required this.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 19.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: backgroundColor == null ? null : Border.all(color: Colors.black),
          color: backgroundColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          text.tr(),
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.dm,
            color: backgroundColor == null ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}