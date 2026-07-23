import 'package:flutter/material.dart';

class CustomTextStyle extends StatelessWidget {
  final String val;
  final Color color;
  final double size;


  CustomTextStyle({
    required this.val,
    required this.color,
    required this.size,
    super.key});

    


  @override
  Widget build(BuildContext context) {
    return Text(
      val,
      style: TextStyle(
        fontSize: size, 
        color: color,
        
      ),
    );
  }
}