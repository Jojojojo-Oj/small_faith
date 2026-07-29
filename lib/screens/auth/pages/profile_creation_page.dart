import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/providers/auth_provider.dart';
import 'package:small_faith/screens/auth/widgets/customTextField.dart';
import 'package:small_faith/screens/homescreen/pages/homescreen_page.dart';

class ProfileCreationPage extends ConsumerStatefulWidget {
  const ProfileCreationPage({super.key});

  @override
  ConsumerState<ProfileCreationPage> createState() => _ProfileCreationPageState();
}

class _ProfileCreationPageState extends ConsumerState<ProfileCreationPage> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _aboutMe = TextEditingController();
  bool _isLoading = false;
  

  
  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _aboutMe.dispose();
   
    super.dispose();
  }

  Future<void> _handleDone() async {
    final firstName = _firstnameController.text.trim();
    final lastName = _lastnameController.text.trim();
    final aboutMe = _aboutMe.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || aboutMe.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in first and last name.')),
      );
      return;
    }

    final user = ref.read(authServiceProvider).currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No signed-in user found.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authServiceProvider).saveUserProfile(
            uid: user.uid,
            email: user.email ?? '',
            firstName: firstName,
            lastName: lastName,
            aboutMe: aboutMe,
            photoUrl: user.photoURL ?? '',
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const HomeScreenPage()),
        (route) => false,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }


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
                    controller: _firstnameController,
                    hintText: "First Name",
                    center: false,
                    maxline: 1,
                  ),

                  SizedBox(height: 20.h),

                  CustomTextField(
                    controller: _lastnameController,
                    hintText: "Last Name",
                    center: false,
                    maxline: 1,
                  ),

                  SizedBox(height: 20.h),

                  CustomTextField(
                    controller: _aboutMe,
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
                      onPressed: _isLoading ? null : _handleDone,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
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
