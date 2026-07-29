  import 'package:flutter/material.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';

  class CustomButton extends StatelessWidget {
    final String buttonName;
    final Color backgroundColor;
    final Color textColor;
    final VoidCallback? methodPress;

    const CustomButton({
      this.methodPress,
      required this.buttonName,
      required this.backgroundColor,
      required this.textColor,    
      
      super.key});

    @override
    Widget build(BuildContext context) {
      return ElevatedButton
      (
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onPressed: methodPress, 
        child: Text(buttonName, style: TextStyle(color: textColor, fontSize: 16.sp),)
      );
    }
  }