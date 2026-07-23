import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:small_faith/features/homescreen/widget/verse_of_the_day_card.dart';
class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  late final DateTime today;
  late final String formattedDate;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    formattedDate = DateFormat('EEEE, MMMM d').format(today);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child:  Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Inter', 
                      fontSize: 16.sp, 
                      fontWeight: FontWeight.w900, 
                      color: Colors.grey),
                    ),
      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Good Morning,", style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w900
                            ),),
      
                            Text("Gilbert", style: TextStyle(
                              fontFamily: 'Inter',
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w900
                            ),),
                          ],
                        ),
      
                        const Spacer(),
                      
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,                       
                          children: [
                            CircleAvatar(
                              radius: 25.r,
                              backgroundColor: Colors.grey,
                            ),
                            
                            Text("Gilbert", style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),)
                          ],
                        )
                      ],
                    ),
      
                    Text("Grow your faith today", style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey),),
      
                    SizedBox(
                      
                      height: 15.h,
                      child: Divider(
                        color:  Colors.white,
                        thickness: .5.sp,
                      ),
                    ),
      
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset("assets/svg/bible_icon.svg", width: 27.w, height: 27.h,),
      
                        SizedBox(width: 10.w,),
      
                        Text("Verse of the Day", style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w900
                        ),)
      
                      ],
                    ),
      
                    SizedBox(height: 10.h,),
      
                    SizedBox(
                      width: double.infinity,
                      child: VerseCard(),)
      
                    
                ],
      
              ),
              ),
          
        ),
      ),
    );
  }
}