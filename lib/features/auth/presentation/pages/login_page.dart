import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/features/auth/presentation/widgets/customTextField.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "What's your", style: TextStyle(fontFamily: 'Inter', fontSize: 36.sp, fontWeight: FontWeight.w900,color: Colors.white ),
              ),
          
              Text(
                "email address?", style: TextStyle(fontFamily: 'Inter', fontSize: 36.sp, fontWeight: FontWeight.w900,color: Colors.white ),
              ),

              SizedBox(height: 20.h,),

              CustomTextField(hintText: "Email Address", center: true,maxline: 1,),

              SizedBox(height: 15.h,),

              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: FilledButton(               
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12.sp)
                    )
                                       
                  ),                 
                  onPressed: (){}, 
                  child: Text("Continue", style: GoogleFonts.inter(fontSize: 20.sp,color: Colors.black),)
                ),
              ),

              SizedBox(height: 15.h,),

              Row(
                children: [
                  // Left side line
                  Expanded(
                    child: Divider(
                      color: Colors.white24, 
                      thickness: 2.sp,          
                    ),
                  ),
                  
                  // Middle text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16), 
                    child: Text(
                      'or continue with',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w200
                      )
                      ),
                    ),                 
                  
                  // Right side line
                  Expanded(
                    child: Divider(
                      color: Colors.white24,
                      thickness: 2.sp,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15.h,),

              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.transparent)
                ),
                onPressed: (){}, 
                child: SvgPicture.asset("assets/svg/googlelogo.svg", width: 40.sp, height: 40.sp,)
                )
              
          
          
            ],
          ),
        ),
      ),
    );
  }
}