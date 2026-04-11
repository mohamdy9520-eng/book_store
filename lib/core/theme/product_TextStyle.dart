import 'package:book_store/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTextstyle {
  static TextStyle title=TextStyle(
    fontSize:14.sp,
    fontWeight:FontWeight.w400,
    color:Color(0xff2F2F2F),
    fontFamily:FontFamily.dm
  );

  static TextStyle price=TextStyle(
    fontSize:16.sp,
    fontWeight: FontWeight.w400,
    color: Color(0xff2F2F2F),
    fontFamily: FontFamily.dm,
  );

  static TextStyle buy=TextStyle(
    fontSize:14.sp,
    fontWeight:FontWeight.w400,
    color: Color(0xffFFFFFF),
    fontFamily: FontFamily.dm
  );
}