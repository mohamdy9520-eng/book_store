import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/core/theme/app_text_style.dart';
import 'package:book_store/core/widgets/app_buttom.dart';
import 'package:book_store/features/welcome/ui/widgets/create_new_password.dart';
import 'package:book_store/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.borderColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      textStyle: AppTextStyle.headline.copyWith(fontSize: 20.sp),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(22.w),
            child: Column(
              children: [
                Text(
                  LocaleKeys.OTP_Verification.tr(),
                  style: AppTextStyle.headline,
                ),

                SizedBox(height: 10.h),

                Text(
                  LocaleKeys.Enter_the_verification_code.tr(),
                  style: AppTextStyle.DontWorry,
                ),
                SizedBox(height: 35.h),

                Pinput(
                  length: 6,
                  controller: otpController,
                  defaultPinTheme: defaultPinTheme,
                  keyboardType: TextInputType.number,
                  onCompleted: (pin) {
                  },
                ),

                SizedBox(height: 35.h),

                AppButton(
                  text: LocaleKeys.OTP_Verification.tr(),
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder:(context)=> CreateNewPassword()));
                  },
                ),

                SizedBox(height: 357.h),

                Text(
                  LocaleKeys.didnt_recieve.tr(),
                  style: AppTextStyle.repassword,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}