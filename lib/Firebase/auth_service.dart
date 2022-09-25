import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:give_a_little_sdp/Encryption/encryption.dart';

//This class is used to verify the details of an existing user
//And Sign out a user

class AuthService {
  //sign out method
  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      rethrow;
    }
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
  Future createUser(name, surname, username, email) async {
    String newEmail = Encryption().getEncryptedEmail(email);

    await FirebaseFirestore.instance.collection('Users').add({
      'name': name,
      'surname': surname,
      'username': username,
      'email': newEmail
    });
  }
}
