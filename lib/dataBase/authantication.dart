import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final _fireAuth = FirebaseAuth.instance;

  String get userUID => _fireAuth.currentUser!.uid;

  // String? get mail => _fireAuth.currentUser!.email;
  Future<String> logIn(String email, String password) async {
    try {
      await _fireAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'true';
    } catch (e) {
      return e.toString();
    }
  }
}
