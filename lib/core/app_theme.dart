import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,


    // Colors
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
    ),




    // Cards
    cardTheme: CardThemeData(

      color: AppColors.card,

      elevation: 2,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),

    ),



    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor: AppColors.primary,

        foregroundColor: Colors.white,

        padding: EdgeInsets.symmetric(
          vertical: 14.h,
          horizontal: 24.w,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),

      ),

    ),


    // AppBar
    appBarTheme: AppBarTheme(

      backgroundColor: AppColors.background,

      elevation: 0,

      titleTextStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.text,
      ),

    ),

  );


}