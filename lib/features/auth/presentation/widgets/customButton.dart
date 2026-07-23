  import 'package:flutter/material.dart';

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
        ),
        onPressed: methodPress, 
        child: Text(buttonName, style: TextStyle(color: textColor),)
      );
    }
  }