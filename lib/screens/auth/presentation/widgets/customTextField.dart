import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool center;
  final int maxline;

  const CustomTextField({
    required this.hintText,
    required this.center,
    required this.maxline,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxline,
      textAlign: center? TextAlign.center : TextAlign.start,

      style: GoogleFonts.inter(
          fontSize: 20.sp,
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
          fontSize: 20.sp,
          fontWeight: FontWeight.w200,
          color: Colors.white,

        ),
        
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey, width: 1.5.sp),
          
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey, width: 1.5.sp),
          
        )
        
      ),
    );
  }
}