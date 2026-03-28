import 'dart:math';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  static Dio dio=Dio();

  static Future<bool>login({required String email,required String password})async{
    try{
      final response=await dio.post("https://codingarabic.online/api/login",
          data: {
            "email":email,
            "password":password
          }
      );
      if(response.statusCode==200){
        saveUserToken(response.data["data"]["token"]);
        return true;

      }else{
        return false;

      }
    }catch(e){
      return false;

    }
  }

  static Future<void>saveUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    print("token Saved");

  }
}

