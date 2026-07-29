import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:small_faith/providers/auth_provider.dart';
import 'package:small_faith/screens/auth/pages/create_password.dart';
import 'package:small_faith/screens/auth/pages/profile_creation_page.dart';
import 'package:small_faith/screens/auth/widgets/customTextField.dart';
import 'package:small_faith/screens/auth/pages/password_page.dart';
import 'package:small_faith/screens/homescreen/pages/homescreen_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an email address.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final exists = await ref.read(authServiceProvider).emailExists(email);

      if (!mounted) return;

      if (exists) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => PasswordPage(email: email)),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No account registered')),
        );
      }
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

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    try {
      await ref.read(authServiceProvider).signInWithGoogle();
      if (!mounted) return;

      final user = ref.read(authServiceProvider).currentUser;
      if (user == null) {
        throw Exception('Google sign-in failed.');
      }

      final hasPasswordProvider = user.providerData.any(
        (info) => info.providerId == 'password',
      );

      if (!hasPasswordProvider) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const CreatePassword()),
          (route) => false,
        );
        return;
      }

      final profile = await ref.read(authServiceProvider).getUserProfile(
            user.uid,
          );

      if (!mounted) return;

      if (profile == null || !profile.isProfileDone) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const ProfileCreationPage()),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomeScreenPage()),
          (route) => false,
        );
      }
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
                    controller: _emailController,
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
                      onPressed: _isLoading ? null : _handleContinue,
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 4,color: Colors.white,),
                            )
                          : Text(
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
                    onPressed: _isLoading ? null : _handleGoogleSignIn,
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
