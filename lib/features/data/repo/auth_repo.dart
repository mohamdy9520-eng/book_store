import 'dart:math';

import 'package:book_store/core/networking/api_constants.dart';
import 'package:book_store/core/networking/dio.helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  static Future<bool>login({required String email,required String password})async{
    try{
      final response=await DioHelper.dio?.post(ApiConstants.login,
          data: {
            "email":email,
            "password":password
          }
      );
      print(response?.data);
      print(response?.statusCode);

      if(response?.statusCode==200 || response?.statusCode==201){
        await saveUserToken(response?.data["data"]["token"]);
        return true;

      }else{
        print("Error");
        return false;

      }
    }catch(e){
      print("Error");
      return false;

    }
  }

  static Future<void>saveUserToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
    print("token Saved");

  }

  static Future<bool>register({
    required String name,
    required String email,
    required String password,
    required String confirmpassword,
})async{
    try{
      final response=await DioHelper.dio!.post(
        ApiConstants.register,
        data: {
          "name":name,
          "email":email,
          "password":password,
          "password_confirmation":password
        }
      );
      print("Status:${response.statusCode}");
      print("Data:${response.data}");

      if(response.statusCode==200 || response.statusCode==201){
        final token=response.data?["data"]?["token"];
        print("Token:$token");

        if(token !=null){
          await saveUserToken(token);
          return true;
        }
      }
      return false;
    }catch(e){
      print("Register error:$e");
      return false;
    }
  }
}

