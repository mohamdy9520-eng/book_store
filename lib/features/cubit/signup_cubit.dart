import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/auth_repo.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  Future<void> submit({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(SignupLoadingState());

    try {
      bool success = await AuthRepo.register(
        name: userName,
        email: email,
        password: password, confirmpassword: '',
      );

      if (success) {
        emit(SignupSuccessState());
      } else {
        emit(SignupErrorState("Register failed"));
      }
    } catch (e) {
      emit(SignupErrorState(e.toString()));
    }
  }
}