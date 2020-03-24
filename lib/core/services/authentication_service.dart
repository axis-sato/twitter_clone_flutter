import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final user = (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  Future<void> signOut() {
    return _auth.signOut();
  }

  Future<FirebaseUser> get currentUser => _auth.currentUser();
}
