import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/screens/auth/widgets/customTextField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  Text(
                    "What's your",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),

                  Text(
                    "email address?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  CustomTextField(
                    
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email Address",
                    center: true,
                    maxline: 1,
                  ),

                  SizedBox(height: 15.h),

                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: (){},
                      child: Text(
                              "Continue",
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                color: Colors.black,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 15.h),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: Colors.white24, thickness: 2.sp),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'or continue with',
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Divider(color: Colors.white24, thickness: 2.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: 15.h),

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.transparent),
                    ),
                    onPressed: (){},
                    child: SvgPicture.asset(
                      "assets/svg/googlelogo.svg",
                      width: 40.sp,
                      height: 40.sp,
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