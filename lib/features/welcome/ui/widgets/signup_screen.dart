import 'package:book_store/core/theme/app_text_style.dart';
import 'package:book_store/core/widgets/app_buttom.dart';
import 'package:book_store/core/widgets/custome_TextForm.dart';
import 'package:book_store/features/welcome/ui/widgets/login_screen.dart';
import 'package:book_store/features/welcome/ui/widgets/password_changed.dart';
import 'package:book_store/gen/fonts.gen.dart';
import 'package:book_store/gen/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 28.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      LocaleKeys.register_greeting.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30.sp,
                        fontFamily: FontFamily.dm,
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  CustomTextFormField(
                    hintText: LocaleKeys.User_Name.tr(),
                  ),

                  SizedBox(height: 11.h),

                  CustomTextFormField(
                    hintText: LocaleKeys.enter_email.tr(),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: 13.h),

                  CustomTextFormField(
                    hintText: "At least 8 chars, A, a, 1, @",
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                  ),

                  SizedBox(height: 12.h),

                  CustomTextFormField(
                    hintText: LocaleKeys.confirm_password.tr(),
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: confirmPasswordController,
                  ),

                  SizedBox(height: 30.h),

                  AppButton(
                    text: LocaleKeys.signup.tr(),
                    onTap: () {
                      String password = passwordController.text;
                      String confirmPassword = confirmPasswordController.text;

                      RegExp passwordRegex = RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$');

                      if (password.isEmpty || confirmPassword.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "Password fields cannot be empty")),
                        );
                      } else if (!passwordRegex.hasMatch(password)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Password must contain: A, a, 1, @ and be at least 8 characters"),
                          ),
                        );
                      } else if (password != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Passwords do not match")),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      }
                    },
                  ),

                  SizedBox(height: 20.sp),

                  Text(
                    LocaleKeys.signUpOption.tr(),
                    style: AppTextStyle.hintStyle,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 15.sp),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/google.png',
                          width: 24,
                          height: 24,
                        ),
                        label: const Text("Google"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 1,
                        ),
                      ),

                      SizedBox(height: 15.sp),

                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/Facebook.png',
                          width: 24,
                          height: 24,
                        ),
                        label: const Text("Facebook"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          elevation: 1,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 100.sp),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(LocaleKeys.Have_an_account.tr()),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(LocaleKeys.login.tr()),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
