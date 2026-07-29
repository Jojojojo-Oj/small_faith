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

  Future<bool> emailExists(String email) async {
    try {
      await signInWithEmailPassword(
        email: email,
        password: '__email_probe_password__',
      );
      await signOut();
      return true;
    } catch (e) {
      final message = e.toString();
      if (message.contains('No account registered')) {
        return false;
      }
      if (message.contains('Please enter a valid email address.')) {
        throw Exception('Please enter a valid email address.');
      }
      if (message.contains('Incorrect email or password.')) {
        return true;
      }
      throw Exception(message);
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