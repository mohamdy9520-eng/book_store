import 'package:book_store/book_store.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: BookStore()));
}

//flutter pub run easy_localization:generate -S assets/translations -O lib/gen/ -o locale_keys.g.dart -f keys
//dart run build_runner build --delete-conflicting-outputs