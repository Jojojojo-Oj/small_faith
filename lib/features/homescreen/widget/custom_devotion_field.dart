import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDevotionField extends StatelessWidget {
  const CustomDevotionField({required this.controller,required this.maxline, required this.hintText,super.key});
  final int maxline;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxline,
      controller: controller,
      style: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w300,
          color: Colors.white,

        ),

      cursorColor: Colors.white,
      cursorWidth: 3.sp,

      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),

        floatingLabelBehavior: FloatingLabelBehavior.never,
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w200,
          color: const Color.fromARGB(255, 119, 119, 119),

        ),
        
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(color: Colors.grey, width: 1.5.sp),
          
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.sp),
          borderSide: BorderSide(color: Colors.grey, width: 1.5.sp),
          
        )
        
      ),
    );
  }
}