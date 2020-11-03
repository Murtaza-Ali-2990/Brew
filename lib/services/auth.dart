import 'package:brew/models/brew_user.dart';
import 'package:brew/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future emailPassSignIn({String email, String password}) async {
    try {
      return _toBrewUser((await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user);
    } catch (e) {
      if (e.code == 'user-not-found') {
        try {
          BrewUser user = _toBrewUser(
              (await _auth.createUserWithEmailAndPassword(
                      email: email, password: password))
                  .user);
          await DatabaseService(uid: user.user).addUserData('', '0', 100);
          return user;
        } catch (e) {
          return e.code;
        }
      } else
        return e.code;
    }
  }

  bool isAnon() {
    return _auth.currentUser.isAnonymous;
  }

  Future anonymousSignIn() async {
    try {
      return _toBrewUser((await _auth.signInAnonymously()).user);
    } catch (e) {
      print('Problem logging in $e');
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Problem logging out $e');
    }
  }

  Stream<BrewUser> get user {
    return _auth.authStateChanges().map(_toBrewUser);
  }

  BrewUser _toBrewUser(User user) {
    return BrewUser(user?.uid);
  }
}
