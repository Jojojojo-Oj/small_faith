import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/features/auth/presentation/widgets/customTextField.dart';

class ProfileCreationPage extends StatelessWidget {
  const ProfileCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70.sp,
                backgroundColor: Colors.grey,
              ),
              SizedBox(height: 40.h,),

              CustomTextField(hintText: "First Name", center: false,maxline: 1,),

              SizedBox(height: 20.h,),

              CustomTextField(hintText: "Last Name", center:  false,maxline: 1,),

              SizedBox(height: 20.h,),

              CustomTextField(hintText: "About Me", center: false, maxline: 7),

              SizedBox(height: 20.h,),

              SizedBox(
                width: double.infinity,
                height: 56.h,

                child: OutlinedButton(                 
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    )
                  ),
                  onPressed: (){}, 
                  child: Text("Done", style:  GoogleFonts.inter(fontSize: 25.sp, fontWeight: FontWeight.w600, color: Colors.white),)
                  ),
              )

              

      

              



            ],
          ),
        ),
      ),
    );
  }
}