import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService();

  static const String _webClientId =
      '334413075050-ob23svlpejcr7r3glo7uf9qugp97o65h.apps.googleusercontent.com';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  /// Listen to auth changes
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  /// Current user
  User? get currentUser => _auth.currentUser;

  Future<bool> emailExists(String email) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: '__email_probe_password__',
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw Exception('Please enter a valid email address.');
      }
      if (e.code == 'wrong-password') {
        return true;
      }
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        return false;
      }
      throw Exception(e.message ?? 'Unable to verify email right now.');
    }
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

    return await _auth.signInWithCredential(credential);
  }

  /// Sign Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}