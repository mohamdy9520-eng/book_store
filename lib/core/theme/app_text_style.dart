
import 'package:book_store/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {


  static TextStyle hintStyle=TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xff8391A1),
    fontFamily: FontFamily.dm

  );

  static TextStyle headline=TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w400,
      fontFamily: FontFamily.dm,
    color: Colors.black
  );

  static TextStyle DontWorry=TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    fontFamily: FontFamily.dm,
    color: Colors.black
  );

  static TextStyle code=TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white
  );

  static TextStyle repassword=TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    fontFamily: FontFamily.dm
  );

  static TextStyle PasswordChanged=TextStyle(
    fontFamily: FontFamily.dm,
    fontWeight: FontWeight.w400,
    fontSize: 26.sp

  );

  static TextStyle Price=TextStyle(
      fontFamily: FontFamily.dm,
      fontWeight: FontWeight.w400,
      fontSize: 16.sp

  );

  static TextStyle Button=TextStyle(
      fontFamily: FontFamily.dm,
      fontWeight: FontWeight.w400,
      fontSize: 20.sp

  );




}