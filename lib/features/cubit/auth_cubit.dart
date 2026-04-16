import 'package:bloc/bloc.dart';
import 'package:book_store/features/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/helper/app_constants.dart';
import '../../core/networking/dio.helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthInitial());

    try {
      final response = await DioHelper.dio!.post(
        "login",
        data: {
          "email": email,
          "password": password,
        },
      );


      final token = response.data["data"]["token"];

      AppConstants.token = token;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);

      emit(AuthSuccessState());

    } catch (e) {
      emit(AuthErrorState());
    }
  }
}
