import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_faith/providers/auth_provider.dart';
import 'package:small_faith/screens/auth/pages/login_page.dart';
import 'package:small_faith/screens/homescreen/pages/homescreen_page.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return const LoginPage();
        }

        return const HomeScreenPage();
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}