import 'package:book_store/core/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: ()async{
            SharedPreferences pref=await SharedPreferences.getInstance();
            await pref.remove("token");
            Navigator.pushNamedAndRemoveUntil(context, Routes.loginScreen, (e)=>false);
          }, icon:Icon(Icons.login))
        ],
      ),
    );
  }
}
