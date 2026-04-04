import 'package:book_store/authentication/signup_screen.dart';
import 'package:book_store/core/widgets/app_buttom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:book_store/gen/assets.gen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../gen/locale_keys.g.dart';
import 'login_screen.dart';




class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image:Assets.images.welcomeBackground.image().image,
          fit: BoxFit.cover)
        ),
        child: Column(
          children: [
            SizedBox(height: 60.h,),

            Row(
              children: [
                IconButton(onPressed: (){
                  if(context.locale.languageCode=="ar"){
                    context.setLocale(Locale("en"));
                  }else{
                    context.setLocale(Locale("ar"));
                  }
                }
                    , icon:Icon(Icons.language)),
              ],
            ),

            SizedBox(height: 90.h,),
            Assets.images.splash.image(),
            SizedBox(height: 28.h,),
            Expanded(
              child: Text(LocaleKeys.orderNow.tr(), style: TextStyle(
                fontSize: 20.sp
              ),),
            ),

            AppButton(
              text: LocaleKeys.login.tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),

            SizedBox(height: 15.h),

            AppButton(
              text: LocaleKeys.signup.tr(),
              backgroundColor: Colors.white,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
            ),
            SizedBox(height: 94.h)


          ],

        ),
      ),

    );
  }
}