import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:give_a_little_sdp/Encryption/encryption.dart';

//This class is used to verify the details of an existing user
//And Sign out a user as well as create a new user

class AuthService {
  final FirebaseAuth auth;

  AuthService({required this.auth});
  //sign out method using firebase Auth
  Future<String> signOut() async {
    try {
      await auth.signOut();
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  //sign in method using email and password using firebase Auth
  Future<String> signIn(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
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

//stores user details in firestore database
//sends the users name,surname,username and encrypted email
  Future<String> createUser(name, surname, username, email) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    String newEmail = Encryption().getEncryptedEmail(email);

    await FirebaseFirestore.instance.collection('Users').doc(uid).set({
      'name': name,
      'surname': surname,
      'username': username,
      'email': newEmail,
      'uid': uid
    });
    return "";
  }
}
