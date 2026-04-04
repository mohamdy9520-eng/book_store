import 'package:book_store/book_store.dart';
import 'package:book_store/core/helper/app_constants.dart';
import 'package:book_store/core/networking/dio.helper.dart';
import 'package:book_store/features/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  DioHelper.init();
  AppConstants.token=prefs.getString("token");



  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: BlocProvider(
        create: (context) => AuthCubit(),
        child: const BookStore(),
      ),
    ),
  );
}

//flutter pub run easy_localization:generate -S assets/translations -O lib/gen/ -o locale_keys.g.dart -f keys
//dart run build_runner build --delete-conflicting-outputs