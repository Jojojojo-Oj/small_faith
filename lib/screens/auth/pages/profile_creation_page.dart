import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:small_faith/screens/auth/widgets/customTextField.dart';
import 'package:small_faith/services/auth_service.dart';

class ProfileCreationPage extends StatefulWidget {
  const ProfileCreationPage({super.key});

  @override
  State<ProfileCreationPage> createState() => _ProfileCreationPageState();
}

class _ProfileCreationPageState extends State<ProfileCreationPage> {
  final AuthService _authService = AuthService();
  final ImagePicker _imagePicker = ImagePicker();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  File? _pickedImage;
  bool _isSaving = false;
  bool _isPickingImage = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    setState(() => _isPickingImage = true);
    try {
      final XFile? picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80, // compress a bit before upload
        maxWidth: 800,
      );

      if (picked == null) return; // user cancelled

      setState(() => _pickedImage = File(picked.path));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open gallery: $e')),
      );
    } finally {
      if (mounted) setState(() => _isPickingImage = false);
    }
  }

  /// Uploads the picked file to Firebase Storage and returns its download URL.
  /// If nothing was picked, falls back to the Google account photo (or empty).
  Future<String> _resolvePhotoUrl(String uid) async {
    if (_pickedImage == null) {
      return _authService.currentUser?.photoURL ?? '';
    }

    final ref = FirebaseStorage.instance
        .ref()
        .child('profile_photos')
        .child('$uid.jpg');

    await ref.putFile(_pickedImage!);
    return await ref.getDownloadURL();
  }

  Future<void> _handleDone() async {
    final user = _authService.currentUser;
    if (user == null) return; // shouldn't happen — AuthGate guards this page

    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    if (firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your first name.')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final photoUrl = await _resolvePhotoUrl(user.uid);

      await _authService.saveUserProfile(
        uid: user.uid,
        email: user.email ?? '',
        firstName: firstName,
        lastName: lastName,
        aboutMe: _aboutMeController.text.trim(),
        photoUrl: photoUrl,
      );

      // No manual navigation here — AuthGate is listening to this profile
      // doc via a live stream, so as soon as isProfileDone flips to true
      // above, AuthGate rebuilds and swaps to HomeScreenPage on its own.
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not save profile: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final googlePhotoUrl = _authService.currentUser?.photoURL;

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
                  Center(
                    child: GestureDetector(
                      onTap: _isPickingImage ? null : _pickImageFromGallery,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CircleAvatar(
                            radius: 70.r,
                            backgroundColor: Colors.grey,
                            backgroundImage: _pickedImage != null
                                ? FileImage(_pickedImage!) as ImageProvider
                                : (googlePhotoUrl != null
                                    ? NetworkImage(googlePhotoUrl)
                                    : null),
                            child: _isPickingImage
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(6.r),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.edit,
                                size: 18.sp,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Center(
                    child: Text(
                      "Tap to choose a photo",
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.white54,
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  CustomTextField(
                    controller: _firstNameController,
                    hintText: "First Name",
                    center: false,
                    maxline: 1,
                  ),

                  SizedBox(height: 20.h),

                  CustomTextField(
                    controller: _lastNameController,
                    hintText: "Last Name",
                    center: false,
                    maxline: 1,
                  ),

                  SizedBox(height: 20.h),

                  CustomTextField(
                    controller: _aboutMeController,
                    hintText: "About Me",
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
                      onPressed: _isSaving ? null : _handleDone,
                      child: _isSaving
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
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