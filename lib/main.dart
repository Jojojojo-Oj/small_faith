import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/features/auth/presentation/pages/login_page.dart';
import 'package:small_faith/features/auth/presentation/pages/profile_creation_page.dart';
import 'package:small_faith/features/homescreen/pages/devotion/devotion_history.dart';
import 'package:small_faith/features/homescreen/pages/devotion/devotion_page.dart';
import 'package:small_faith/firebase_options.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          home: const ProfileCreationPage(),
        );
      },
    );

  }

}