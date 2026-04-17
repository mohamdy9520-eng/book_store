import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData? icon;

  const ProfileItem({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.r),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        height: 54.h,
        width: 335.w,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20.sp),
              SizedBox(width: 10.w),
            ],

            Text(
              title,
              style: TextStyle(fontSize: 14.sp),
            ),

            const Spacer(),

            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}