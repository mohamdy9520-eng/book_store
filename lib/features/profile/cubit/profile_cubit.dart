import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/networking/dio.helper.dart';
import '../data/profile_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getUserData() async {
    emit(ProfileLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        emit(ProfileError(message: "Token not found"));
        return;
      }

      final response = await DioHelper.getData(
        endPoint: "profile",
        token: token,
        url: '',
      );

      final user = UserModel.fromJson(response.data["data"]);

      await prefs.setString("user", jsonEncode(user.toJson()));

      emit(ProfileLoaded(user));

    } on DioException catch (e) {
      print("DIO ERROR => ${e.response?.data}");

      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString("user");

      if (cachedData != null) {
        final user = UserModel.fromJson(jsonDecode(cachedData));
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError(message: "Network error"));
      }

    } catch (e) {
      emit(ProfileError(message: "Unexpected error"));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String email,
  }) async {
    emit(ProfileLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      if (token == null) {
        emit(ProfileError(message: "Token not found"));
        return;
      }

      await DioHelper.putData(
        "profile",
        {
          "name": name,
          "email": email,
        },
        token!, url: '',
        endPoint: 'profile',
        token:token!,
      );

      await getUserData();

    } on DioException catch (e) {
      emit(ProfileError(
        message: e.response?.data["message"] ?? "Update failed",
      ));
    } catch (e) {
      emit(ProfileError(message: "Unexpected error"));
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    emit(ProfileInitial());
  }
}