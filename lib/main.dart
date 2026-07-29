import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/features/homescreen/pages/devotion/devotion_history.dart';
import 'package:small_faith/features/homescreen/pages/devotion/devotion_page.dart';



void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          home: const DevotionPage(),
        );
      },
    );

  }

}