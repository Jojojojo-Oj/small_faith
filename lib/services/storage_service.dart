import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

/// Handles file uploads to Firebase Storage.
/// Kept separate from AuthService since uploading files isn't an
/// authentication concern — this can be reused anywhere else in the
/// app that needs to upload something later.
class StorageService {
  StorageService();

  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Uploads a profile photo for [uid] and returns its public download URL.
  Future<String> uploadProfilePhoto({
    required String uid,
    required File file,
  }) async {
    final ref = _storage.ref().child('profile_photos').child('$uid.jpg');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}