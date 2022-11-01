import 'package:firebase_auth/firebase_auth.dart';

//This class is used to verify the details of an existing user
//And Sign out a user as well as create a new user

class AuthService {
  final FirebaseAuth auth;

  AuthService({required this.auth});
  //sign out method using firebase Auth
  Future<String> signOut() async {
    await auth.signOut();
    return "Success";
  }

  //sign in method using email and password using firebase Auth

  Future<String> signIn(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return "email or password is incorrect";
    }
  }

//Used to sign up new users using firebase Auth

  Future<String> signUp(email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Account Created";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
