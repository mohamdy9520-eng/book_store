import 'package:bloc/bloc.dart';
import 'package:book_store/features/data/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../core/helper/app_constants.dart';
import '../../core/helper/cach_helper.dart';
import '../../core/networking/api_constants.dart';
import '../../core/networking/dio.helper.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginWithFirebase({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthErrorState("User not found"));
      } else if (e.code == 'wrong-password') {
        emit(AuthErrorState('Wrong password'));
      } else {
        emit(AuthErrorState(e.message ?? "Login error"));
      }
    } catch (e) {
      emit(AuthErrorState("Unexpected error"));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoadingState());

    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        emit(AuthErrorState("Login cancelled"));
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoadingState());

    try {
      await FirebaseAuth.instance.signOut();
      emit(AuthLoggedOutState());
    } catch (e) {
      emit(AuthErrorState("Logout failed"));
    }
  }
}