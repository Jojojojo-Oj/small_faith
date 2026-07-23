import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VerseCard extends StatelessWidget {
  const VerseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromRGBO(43, 87, 72, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20.r)
      ),

      clipBehavior: Clip.antiAlias,
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/hill.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Color.fromRGBO(43, 87, 72, .25), // dark overlay
        ),
      
      
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mark 9:23", style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 24.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white
            ),
            ),
            15.verticalSpace,
            Text("Everything is possible for one who believes", style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),),

            20.verticalSpace
          ],
        ),)
    )
    )
    );
  }
}