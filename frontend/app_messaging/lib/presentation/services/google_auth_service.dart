import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<void> initialize() async {
    await _googleSignIn.initialize(
      serverClientId:
          '186873501820-lm9kjviulqf049euhag83okrmqt4bmt3.apps.googleusercontent.com',
    );
  }

  Future<String?> signIn() async {
    try {
      final GoogleSignInAccount account = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication auth = account.authentication;

      return auth.idToken;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
