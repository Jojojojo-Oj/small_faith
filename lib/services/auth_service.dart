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

  /// Listen to auth changes (null when signed out)
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  /// Current Firebase user, if any
  User? get currentUser => _auth.currentUser;

  /// One-time fetch of the user's profile doc
  Future<UserModel?> getUserProfile(String uid) async {
    final snapshot = await _usersCollection.doc(uid).get();
    final data = snapshot.data();
    if (data == null) return null;
    return UserModel.fromMap(snapshot.id, data);
  }

  /// Live stream of the user's profile doc (useful if profile can change
  /// elsewhere in the app, e.g. editing later)
  Stream<UserModel?> userProfileChanges(String uid) {
    return _usersCollection.doc(uid).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) return null;
      return UserModel.fromMap(snapshot.id, data);
    });
  }

  /// Creates a bare-bones profile doc right after first sign-in.
  /// isProfileDone starts false so AuthGate routes to ProfileCreationPage.
  /// If the doc already exists, this does nothing (won't overwrite progress).
  Future<void> ensureUserProfileForCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final doc = _usersCollection.doc(user.uid);
    final snapshot = await doc.get();

    if (snapshot.exists) return;

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

  /// Called from ProfileCreationPage's "Done" button
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

  /// Google Sign In (also used for sign up — same flow, first-time doc
  /// creation happens in ensureUserProfileForCurrentUser)
  Future<UserCredential> signInWithGoogle() async {
    await _googleSignIn.initialize(serverClientId: _webClientId);

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    await ensureUserProfileForCurrentUser();
    return userCredential;
  }

  /// Sign Out (does NOT touch Firestore — profile stays saved for next login)
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}