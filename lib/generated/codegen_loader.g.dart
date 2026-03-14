// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "login": "تسجيل الدخول",
  "signup": "التسجيل",
  "orderNow": "احجز كتابك الان!",
  "Welcome back": "مرحبًا بعودتك! سعداء برؤيتك مرة أخرى!",
  "register_greeting": "مرحبًا! أنشئ حسابك للبدء",
  "enter_email": "البريد الإلكتروني",
  "User Name": "اسم المستخدم",
  "Password": "كلمة المرور",
  "confirm_password": "تأكيد كلمة المرور",
  "Forget Password?": "هل نسيت كلمة المرور",
  "Dont have an account?Register now!": "ليس لديك حساب؟سجل الان!"
};
static const Map<String,dynamic> _en = {
  "login": "Login",
  "signup": "Sign Up",
  "orderNow": "Order Your Book Now!",
  "Welcome back": "Welcome back! Glad to see you, Again!",
  "register_greeting": "Hello! Register to get started",
  "enter_email": "Enter your email",
  "Password": "Password",
  "confirm_password": "Confirm Password",
  "user_name": "Username",
  "Forget Password": "Forget Password",
  "Don't have an account?Register now!": "Don't have an account?Register now!"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
