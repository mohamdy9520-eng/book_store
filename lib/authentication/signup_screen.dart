import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/theme/app_text_style.dart';
import '../core/widgets/app_buttom.dart';
import '../core/widgets/custome_TextForm.dart';
import '../features/cubit/signup_cubit.dart';
import '../gen/fonts.gen.dart';
import '../gen/locale_keys.g.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocListener<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is SignupSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
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
                          controller: userNameController,
                          hintText: LocaleKeys.User_Name.tr(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 11.h),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: LocaleKeys.enter_email.tr(),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your email";
                            }
                            if (!value.contains("@")) {
                              return "Invalid email";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 13.h),

                        CustomTextFormField(
                          controller: passwordController,
                          hintText: "At least 8 chars, A, a, 1, @",
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.length < 6) {
                              return "Password too weak";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12.h),
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          hintText: LocaleKeys.confirm_password.tr(),
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 30.h),
                        BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            if (state is SignupLoadingState) {
                              return const CircularProgressIndicator();
                            }

                            return AppButton(
                              text: LocaleKeys.signup.tr(),
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<SignupCubit>().submit(
                                    userName:
                                    userNameController.text.tr(),
                                    email: emailController.text.tr(),
                                    password: passwordController.text,
                                    confirmPassword:
                                    confirmPasswordController.text,
                                  );
                                }
                              },
                            );
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
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: Image.asset(
                                'assets/images/google.png',
                                width: 24,
                                height: 24,
                              ),
                              label: const Text("Google"),
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
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
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
          ),
        ),
      ),
    );
  }
}