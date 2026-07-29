import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:small_faith/screens/auth/model/user_model.dart';

import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges();
});

final userProfileProvider =
    StreamProvider.family<UserModel?, String>((ref, uid) {
  return ref.watch(authServiceProvider).userProfileChanges(uid);
});