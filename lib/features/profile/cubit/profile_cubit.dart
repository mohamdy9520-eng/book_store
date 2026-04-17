import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/profile_model.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final Dio dio = Dio();

  Future<void> getUserData() async {
    emit(ProfileLoading());

    try {
      print("🔥 getUserData CALLED");

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      print("TOKEN => $token");

      final response = await dio.get(
        "https://codingarabic.online/api/profile",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      print("RESPONSE => ${response.data}");

      final user = UserModel.fromJson(response.data["data"]);

      prefs.setString("user", jsonEncode(user.toJson()));

      emit(ProfileLoaded(user));

    } catch (e) {
      print("PROFILE ERROR FULL => $e");

      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString("user");

      if (cachedData != null) {
        final user = UserModel.fromJson(jsonDecode(cachedData));
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError());
      }
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("user");
    await prefs.remove("token");

    emit(ProfileInitial());
  }
}