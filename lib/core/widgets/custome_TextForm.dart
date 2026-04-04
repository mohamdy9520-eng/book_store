import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../gen/assets.gen.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final Color? hintColor;
  final bool isPassword;
  final String? Function(String?)? validator;


  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.hintColor,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primaryColor,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? isObsecure : false,
      validator: widget.validator,

      onTapOutside: (v) {
        FocusScope.of(context).unfocus();
      },

      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? Padding(
          padding: EdgeInsets.all(8.r),
          child: InkWell(
            onTap: () {
              setState(() {
                isObsecure = !isObsecure;
              });
            },
            child:isObsecure?Icon(Icons.visibility_off):SvgPicture.asset(Assets.images.visaIcon)
          ),
        )
            : null,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),

        hintText: widget.hintText,

        prefixIcon: widget.prefixIcon != null
            ? Icon(
          widget.prefixIcon,
          size: 20.sp,
        )
            : null,

        filled: true,
        fillColor: AppColors.grayColor,

        hintStyle: AppTextStyle.hintStyle,

        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 18.h,
        ),
      ),
    );
  }
}