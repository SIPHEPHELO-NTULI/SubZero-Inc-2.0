import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:give_a_little_sdp/Encryption/encryption.dart';

//This class houses the necessary firebase functions related to creating a new user
//It takes in a required parameter that is instances of firebas, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance
class CreateUser {
  final FirebaseFirestore fire;

  CreateUser({required this.fire});

//stores user details in firestore database
//sends the users name,surname,username and encrypted email
  Future<String> createUser(name, surname, username, email, uid) async {
    String newEmail = Encryption().getEncryptedEmail(email);
    await fire.collection('Users').doc(uid).set({
      'name': name,
      'surname': surname,
      'username': username,
      'email': newEmail,
      'uid': uid
    });
    return "Account Created";
  }
}
