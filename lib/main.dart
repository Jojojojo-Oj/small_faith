import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/features/auth/presentation/pages/diceroll.dart';
import 'package:small_faith/features/auth/presentation/pages/login_page.dart';
import 'package:small_faith/features/auth/presentation/pages/onboarding_page.dart';
import 'package:small_faith/features/auth/presentation/pages/profile_creation_page.dart';
import 'package:small_faith/features/homescreen/pages/homescreen_page.dart';



void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){

    return ScreenUtilInit(

      designSize: const Size(390, 844),

      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child){
        return MaterialApp(
          theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(),
            
          ),
          debugShowCheckedModeBanner: false,
          home: HomeScreenPage(),
        );
      },
    );

  }

}