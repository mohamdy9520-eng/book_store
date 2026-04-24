import 'package:book_store/authentication/signup_screen.dart';
import 'package:book_store/core/routes/routes.dart';
import 'package:book_store/core/theme/app_colors.dart';
import 'package:book_store/core/widgets/app_buttom.dart';
import 'package:book_store/core/widgets/custome_TextForm.dart';
import 'package:book_store/features/cubit/auth_cubit.dart';
import 'package:book_store/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../gen/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 29.h),
                Text(
                  LocaleKeys.Welcome_back.tr(),
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.dm,
                    color: const Color(0xff2F2F2F),
                  ),
                ),
                SizedBox(height: 32.h),
                CustomTextFormField(
                  controller: emailController,
                  hintText: LocaleKeys.enter_email.tr(),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15.h),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                ),
                SizedBox(height: 13.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      LocaleKeys.Forget_Password.tr(),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 62.h),

                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoadingState) {
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: CircularProgressIndicator(
                                color: AppColors.primaryColor),
                          ),
                        ),
                      );
                    } else if (state is AuthErrorState) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Error"),
                          content: const Text(
                              "Something Wrong Happened, Please Try Again!"),
                        ),
                      );
                    } else if (state is AuthSuccessState) {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.bottomNavBarScreen,
                            (route) => false,
                      );
                    }
                  },
                  child: AppButton(
                    text: LocaleKeys.login.tr(),
                    onTap: () async {
                      String email = emailController.text.tr();
                      String password = passwordController.text.tr();

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Email and Password cannot be empty"),
                          ),
                        );
                      } else {
                        context.read<AuthCubit>().loginWithFirebase(
                          email: email,
                          password: password,
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 34.h),
                Text(
                  "OR",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    fontFamily: FontFamily.dm,
                    color: const Color(0xff6A707C),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 21.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/google.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                      label: const Text("Google"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 1,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/Facebook.png',
                        width: 24.w,
                        height: 24.h,
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
                SizedBox(height: 84.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(LocaleKeys.no_account.tr()),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()),
                        );
                      },
                      child: Text(LocaleKeys.signup.tr()),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}