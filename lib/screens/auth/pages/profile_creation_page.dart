import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/screens/auth/widgets/customTextField.dart';

class ProfileCreationPage extends StatefulWidget {
  const ProfileCreationPage({super.key});

  @override
  State<ProfileCreationPage> createState() => _ProfileCreationPageState();
}

class _ProfileCreationPageState extends State<ProfileCreationPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(radius: 70.r, backgroundColor: Colors.grey),
                  SizedBox(height: 40.h),

                  CustomTextField(
                    
                    hintText: "First Name",
                    center: false,
                    maxline: 1,
                  ),

                  SizedBox(height: 20.h),

                  CustomTextField(
                    
                    hintText: "Last Name",
                    center: false,
                    maxline: 1,
                  ),

                  SizedBox(height: 20.h),

                  CustomTextField(
                    
                    hintText: "About Me ",
                    center: false,
                    maxline: 7,
                  ),

                 

                 
                  SizedBox(height: 40.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,

                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white, width: 1.5.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: (){},
                      child:  Text(
                              "Done",
                              style: GoogleFonts.inter(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
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