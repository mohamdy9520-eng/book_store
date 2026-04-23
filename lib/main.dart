import 'package:book_store/authentication/login_screen.dart';
import 'package:book_store/authentication/welcome_screen.dart';
import 'package:book_store/features/cubit/auth_cubit.dart';
import 'package:book_store/features/home/ui/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'book_store.dart';
import 'core/networking/dio.helper.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/home/cubit/home_cubit.dart';
import 'features/wishlist/cubit/wishlist_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();

  DioHelper.init();

  final user = FirebaseAuth.instance.currentUser;

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context)=>AuthCubit()),
          BlocProvider(create: (context) => HomeCubit()),
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => WishlistCubit()),
        ],
        child: BookStore(
          startWidget: user != null ? const HomeScreen() : const WelcomeScreen(),
        ),
      ),
    ),
  );
}