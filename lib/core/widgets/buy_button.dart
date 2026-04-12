import 'package:book_store/features/cart/model/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/cart/cubit/cart_cubit.dart';
import '../theme/app_colors.dart';
import '../theme/product_TextStyle.dart';

class BuyButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;


  const BuyButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 4,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 72.w,
        height: height ?? 28.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.buyBottonColor,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: Text(
          text,
          style: ProductTextstyle.buy.copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}