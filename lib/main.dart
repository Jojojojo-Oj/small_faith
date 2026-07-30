import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod/riverpod.dart';
import 'package:small_faith/firebase_options.dart';
import 'package:small_faith/screens/auth/pages/login_page.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(child: MyApp())
  );
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
          home: LoginPage(),
        );
      },
    );

  }

}