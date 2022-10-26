import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:give_a_little_sdp/Encryption/encryption.dart';
import 'package:give_a_little_sdp/Models/user_model.dart';

class AccountDetails {
  final FirebaseFirestore fire;
  final FirebaseAuth auth;

  AccountDetails({required this.fire, required this.auth});

  Future getUserAccountDetails(String uid) async {
    DocumentSnapshot doc = await fire.collection("Users").doc(uid).get();
    return doc;
  }

  Future<String> getUserName(String uid) async {
    String name = "";
    UserModel userModel;
    await getUserAccountDetails(uid).then((value) => {
          userModel = UserModel.fromMap(value.data()),
          name = userModel.name.toString()
        });
    return name;
  }

  Future<String> getUserAccountImage(String uid) async {
    var collection = fire.collection("Users");
    String imageURL;
    var docSnapshot = await collection.doc(uid).get();
    Map<String, dynamic>? data = docSnapshot.data();

    if (data?['profilePicture'] == null) {
      imageURL =
          "https://firebasestorage.googleapis.com/v0/b/flutterwebdemo-75af3.appspot.com/o/GiveALittle%2FaccountLogo.png?alt=media&token=b6b50463-becf-4c88-9463-7bf021c106b1";
    } else {
      imageURL = data?['profilePicture'];
    }
    return imageURL;
  }

  Future<String> sendUpdatedDetails(String downloadURL, String name,
      String surname, String username, String oldemail, String email) async {
    User? user = auth.currentUser!;
    String newEmail = Encryption().getEncryptedEmail(email);
    await fire.collection('Users').doc(user.uid).set({
      'name': name,
      'surname': surname,
      'username': username,
      'email': newEmail,
      'uid': user.uid,
      'profilePicture': downloadURL
    });
    if (oldemail != newEmail) {
      try {
        await auth.currentUser!.updateEmail(email);
        return "Details Updated";
      } on FirebaseAuthException catch (e) {
        return e.message.toString();
      }
    } else {
      return "Details Updated";
    }
  }
}
