import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:small_faith/screens/auth/model/user_model.dart';

class AuthService {
  AuthService();

  static const String _webClientId =
      '334413075050-ob23svlpejcr7r3glo7uf9qugp97o65h.apps.googleusercontent.com';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  /// Listen to auth changes
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  /// Current user
  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw Exception('Please enter a valid email address.');
      }
      if (e.code == 'user-not-found') {
        throw Exception('No account registered');
      }
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw Exception('Incorrect email or password.');
      }
      throw Exception(e.message ?? 'Unable to sign in right now.');
    }
  }

  Future<void> linkPasswordToCurrentUser({required String password}) async {
    final user = _auth.currentUser;
    final email = user?.email;

    if (user == null || email == null || email.isEmpty) {
      throw Exception('No signed-in Google account found.');
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await user.linkWithCredential(credential);
      await user.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'provider-already-linked') {
        throw Exception('This account already has a password.');
      }
      if (e.code == 'credential-already-in-use') {
        throw Exception('That password is already linked to another account.');
      }
      if (e.code == 'weak-password') {
        throw Exception('Password is too weak.');
      }
      throw Exception(e.message ?? 'Unable to create password right now.');
    }
  }

  Stream<UserModel?> userProfileChanges(String uid) {
    return _usersCollection.doc(uid).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) {
        return null;
      }
      return UserModel.fromMap(snapshot.id, data);
    });
  }

  Future<UserModel?> getUserProfile(String uid) async {
    final snapshot = await _usersCollection.doc(uid).get();
    final data = snapshot.data();
    if (data == null) {
      return null;
    }
    return UserModel.fromMap(snapshot.id, data);
  }

  Future<void> ensureUserProfileForCurrentUser() async {
    final user = _auth.currentUser;

    if (user == null) {
      return;
    }

    final doc = _usersCollection.doc(user.uid);
    final snapshot = await doc.get();

    if (snapshot.exists) {
      await doc.set(
        {
          'email': user.email?.toLowerCase() ?? '',
          'photoUrl': user.photoURL ?? '',
          'updatedAt': DateTime.now().toIso8601String(),
        },
        SetOptions(merge: true),
      );
      return;
    }

    await doc.set(
      UserModel(
        uid: user.uid,
        email: user.email?.toLowerCase() ?? '',
        firstName: user.displayName?.split(' ').firstOrNull ?? '',
        lastName: '',
        aboutMe: '',
        photoUrl: user.photoURL ?? '',
        isProfileDone: false,
      ).toMap(),
    );
  }

  Future<void> saveUserProfile({
    required String uid,
    required String email,
    required String firstName,
    required String lastName,
    required String aboutMe,
    required String photoUrl,
  }) async {
    await _usersCollection.doc(uid).set(
      UserModel(
        uid: uid,
        email: email.toLowerCase(),
        firstName: firstName,
        lastName: lastName,
        aboutMe: aboutMe,
        photoUrl: photoUrl,
        isProfileDone: true,
      ).toMap(),
      SetOptions(merge: true),
    );
  }

  Future<void> setProfileDone({
    required String uid,
    required bool isProfileDone,
  }) async {
    await _usersCollection.doc(uid).set(
      {
        'isProfileDone': isProfileDone,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      SetOptions(merge: true),
    );
  }

  Future<bool> emailExists(String email) async {
    final normalizedEmail = email.trim().toLowerCase();

    if (normalizedEmail.isEmpty) {
      throw Exception('Please enter a valid email address.');
    }

    final snapshot = await _usersCollection
        .where('email', isEqualTo: normalizedEmail)
        .limit(1)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  /// Google Sign In
  Future<UserCredential> signInWithGoogle() async {
    await _googleSignIn.initialize(serverClientId: _webClientId);

    final GoogleSignInAccount googleUser =
        await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    await ensureUserProfileForCurrentUser();
    return userCredential;
  }

  /// Sign Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}