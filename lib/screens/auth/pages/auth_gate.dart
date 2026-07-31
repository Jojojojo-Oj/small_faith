import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:small_faith/screens/auth/model/user_model.dart';
import 'package:small_faith/screens/auth/pages/login_page.dart';
import 'package:small_faith/screens/auth/pages/profile_creation_page.dart';
import 'package:small_faith/screens/homescreen/pages/homescreen_page.dart';
import 'package:small_faith/services/auth_service.dart';

/// Sits at the root of the app (put this as MaterialApp's `home:`).
/// This is the ONLY place that should decide Login vs ProfileCreation vs
/// Home — screens below it should never manually Navigator.push to swap
/// between these three, or they'll end up stacked on top of AuthGate and
/// hide its rebuilds (e.g. sign out not visually updating).
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authService.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const _LoadingScreen();
        }

        final user = authSnapshot.data;

        if (user == null) {
          return const LoginPage();
        }

        // Live stream instead of a one-time fetch — as soon as
        // ProfileCreationPage saves isProfileDone: true to Firestore,
        // this rebuilds automatically and swaps to HomeScreenPage.
        return StreamBuilder<UserModel?>(
          key: ValueKey(user.uid),
          stream: _authService.userProfileChanges(user.uid),
          builder: (context, profileSnapshot) {
            if (profileSnapshot.connectionState == ConnectionState.waiting) {
              return const _LoadingScreen();
            }

            final profile = profileSnapshot.data;

            if (profile == null || !profile.isProfileDone) {
              return const ProfileCreationPage();
            }

            return const HomeScreenPage();
          },
        );
      },
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}