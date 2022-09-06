import 'package:firebase_auth/firebase_auth.dart';

//This class is used to verify the details of an existing user
//And Sign out a user

class AuthService {
  //sign out method
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //sign in method using email and password
  signIn(email, password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {})
        .catchError((e) {
      print(e);
    });
  }
}
