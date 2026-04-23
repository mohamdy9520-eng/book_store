import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitialState());

  Future<void> submit({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      emit(SignupErrorState("Passwords do not match"));
      return;
    }

    await registerWithFirebase(
      email: email,
      password: password,
    );
  }

  Future<void> registerWithFirebase({
    required String email,
    required String password,
  }) async {
    emit(SignupLoadingState());

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(SignupSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(SignupErrorState('Email already exists'));
      } else if (e.code == 'weak-password') {
        emit(SignupErrorState("Weak password"));
      } else {
        emit(SignupErrorState(e.message ?? "Error"));
      }
    }
  }
}