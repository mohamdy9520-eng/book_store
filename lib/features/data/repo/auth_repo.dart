import 'package:book_store/core/networking/api_constants.dart';
import 'package:book_store/core/networking/dio.helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<bool> loginApi({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioHelper.dio!.post(
        ApiConstants.login,
        data: {
          "email": email,
          "password": password,
        },
      );

      print(response.data);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        await saveUserToken(response.data["data"]["token"]);
        return true;
      }

      return false;
    } catch (e) {
      print("Login API Error: $e");
      return false;
    }
  }

  Future<bool> loginWithFirebase({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }

      return false;
    } catch (e) {
      print("Firebase Login Error: $e");
      return false;
    }
  }

  static Future<void> saveUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    print("token Saved");
  }

  static Future<bool> registerApi({
    required String name,
    required String email,
    required String password,
    required String confirmpassword,
  }) async {
    try {
      final response = await DioHelper.dio!.post(
        ApiConstants.register,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "password_confirmation": confirmpassword,
        },
      );

      print("Status:${response.statusCode}");
      print("Data:${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = response.data["data"]["token"];

        if (token != null) {
          await saveUserToken(token);
          return true;
        }
      }

      return false;
    } catch (e) {
      print("Register API error: $e");
      return false;
    }
  }

  Future<bool> registerWithFirebase({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Weak password.');
      } else if (e.code == 'email-already-in-use') {
        print('Email already exists.');
      }

      return false;
    } catch (e) {
      print("Firebase Register Error: $e");
      return false;
    }
  }
}