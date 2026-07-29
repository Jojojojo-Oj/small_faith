import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DevotionHistoryCard extends StatelessWidget {
  const DevotionHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 10, 10, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12.r),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.menu_book_rounded, color: Colors.grey[400]),

                10.horizontalSpace,
                Text(
                  "Scripture",
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),

            Text("John 3:16",style: GoogleFonts.inter(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: Colors.white
            ),),

            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud...",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w300,
              color: Colors.grey[400],
              fontSize: 15
              
            ),),

            10.verticalSpace,

            Text("June 18, 2026", 
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.grey[400]
            ),)
          ],

            
        ),
      ),
    );
  }
}
