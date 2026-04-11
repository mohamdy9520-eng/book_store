import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/core/theme/product_TextStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuyButton extends StatelessWidget{
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;

   BuyButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderRadius=4,
    this.textColor
});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72.2275390625.w,
        height: 27.90070915222168.h,
        alignment:Alignment.bottomLeft,
        decoration: BoxDecoration(
          color:AppColors.buyBottonColor,
          borderRadius: BorderRadiusGeometry.circular(4.r)
        ),
        child: Center(child: Text("Buy",style: ProductTextstyle.buy))

      ),
    );
  }
}