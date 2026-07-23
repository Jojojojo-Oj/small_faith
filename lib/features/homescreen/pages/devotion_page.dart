import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/features/homescreen/widget/custom_devotion_field.dart';

class DevotionPage extends StatefulWidget {
  const DevotionPage({super.key});

  @override
  State<DevotionPage> createState() => _DevotionPageState();
}

class _DevotionPageState extends State<DevotionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(20),
        actions: [Icon(Icons.history)],
        leadingWidth: 56.w,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          'Devotion',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1.  Scripture",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    "Read and reflect on God’s Word",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(186, 186, 186, 1),
                      fontSize: 17.sp,
                    ),
                  ),

                  10.verticalSpace,
                  const CustomDevotionField(maxline: 10, hintText: "Bible Verse..."),
                  10.verticalSpace,

                  Text(
                    "2.  Observation",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    "What I notice in the passage",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(186, 186, 186, 1),
                      fontSize: 17.sp,
                    ),
                  ),

                  10.verticalSpace,
                  const CustomDevotionField(maxline: 10, hintText: "Observation on the Verse..."),
                  10.verticalSpace,

                  Text(
                    "3.  Application",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    "What is my life application for today",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(186, 186, 186, 1),
                      fontSize: 17.sp,
                    ),
                  ),

                  10.verticalSpace,
                  const CustomDevotionField(maxline: 10, hintText: "Life Application..."),
                  10.verticalSpace,

                  Text(
                    "4.  Prayer",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    "My response to God",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w300,
                      color: const Color.fromRGBO(186, 186, 186, 1),
                      fontSize: 17.sp,
                    ),
                  ),

                  10.verticalSpace,
                  const CustomDevotionField(maxline: 10, hintText: "Your Prayers..."),
                  10.verticalSpace,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(43, 87, 72, 1),
                          ),
                          onPressed: () {},
                          child: Text(
                            "FINISH AND SAVE",
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
