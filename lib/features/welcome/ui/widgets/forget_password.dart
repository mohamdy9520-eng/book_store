import 'package:book_store/core/theme/app_text_style.dart';
import 'package:book_store/core/widgets/app_buttom.dart';
import 'package:book_store/core/widgets/custome_TextForm.dart';
import 'package:book_store/features/welcome/ui/widgets/otp_verification.dart';
import 'package:book_store/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(22.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),

              Text(
                LocaleKeys.Forget_Password.tr(),
                style: AppTextStyle.headline,
                textAlign: TextAlign.left,
              ),

              SizedBox(height: 10.h),

              Text(
                LocaleKeys.Dont_Worry.tr(),
                style: AppTextStyle.DontWorry,
              ),

              SizedBox(height: 30.h),

              CustomTextFormField(
                hintText: LocaleKeys.enter_email.tr(),
                  keyboardType: TextInputType.emailAddress
              ),

              SizedBox(height: 38.h),

              AppButton(
                text: LocaleKeys.Send_Code.tr(),
                onTap:(){Navigator.push(context,MaterialPageRoute(builder:
                (context)=>const Otp()));
                }
              ),

              SizedBox(height: 361.h),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.re_password.tr(),
                    style: AppTextStyle.repassword),
                    TextButton(onPressed:(){
                      Navigator.pop(context);
                    }, child:Text(LocaleKeys.login.tr())
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}