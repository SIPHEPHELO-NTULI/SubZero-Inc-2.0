import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//This class is used to verify the details of an existing user
//And Sign out a user

class AuthService {
  //sign out method
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //sign in method using email and password
  Future<String> signIn(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

//Used to sign up new users
  Future<String> signUp(email, password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

//stores user details in database
  void createUser(name, surname, username, email) {
    FirebaseFirestore.instance.collection('Users').add({
      'name': name,
      'surname': surname,
      'username': username,
      'email': email
    });
  }
}
