import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    try {
      // AuthGate listens to authStateChanges() and will automatically
      // route to ProfileCreationPage or HomeScreenPage once this succeeds —
      // no manual navigation needed here.
      await _authService.signInWithGoogle();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-in failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Let's get",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),

                  Text(
                    "started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    "Sign in with Google to continue",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      color: Colors.white54,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            onPressed: _handleGoogleSignIn,
                            icon: SvgPicture.asset(
                              "assets/svg/googlelogo.svg",
                              width: 22.sp,
                              height: 22.sp,
                            ),
                            label: Text(
                              "Continue with Google",
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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