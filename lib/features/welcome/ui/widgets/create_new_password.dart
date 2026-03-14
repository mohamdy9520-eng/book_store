import 'package:book_store/core/theme/app_text_style.dart';
import 'package:book_store/core/widgets/app_buttom.dart';
import 'package:book_store/core/widgets/custome_TextForm.dart';
import 'package:book_store/features/welcome/ui/widgets/password_changed.dart';
import 'package:book_store/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewPassword extends StatelessWidget {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  CreateNewPassword({super.key});

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
            children: [
              Text(
                LocaleKeys.create_new_password.tr(),
                style: AppTextStyle.headline,
                textAlign: TextAlign.left,
              ),

              SizedBox(height: 10.h),

              Text(
                LocaleKeys.Conditions.tr(),
                style: AppTextStyle.DontWorry,
                textAlign: TextAlign.left,
              ),

              SizedBox(height: 32.h),

              CustomTextFormField(
                hintText: "A,a,1,@ (min 8)",
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: passwordController,
              ),

              SizedBox(height: 15.h),

              CustomTextFormField(
                hintText: LocaleKeys.Confirm_Password.tr(),
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: confirmPasswordController,
              ),


              SizedBox(height: 38.h),

              AppButton(
                text: LocaleKeys.create_new_password.tr(),
                onTap: () {
                  String password = passwordController.text;
                  String confirmPassword = confirmPasswordController.text;

                  RegExp passwordRegex =
                  RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$');

                  if (!passwordRegex.hasMatch(password)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Password must contain: A, a, 1, @ and be at least 8 characters",
                        ),
                      ),
                    );
                  } else if (password != confirmPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password doesn't match"),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PasswordChanged(),
                      ),
                    );
                  }
                },
              )


            ],
          ),
        ),
      ),
    );
  }
}
