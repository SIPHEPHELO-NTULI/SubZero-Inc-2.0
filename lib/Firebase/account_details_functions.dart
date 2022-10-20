import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:give_a_little_sdp/Encryption/encryption.dart';

class AccountDetails {
  final FirebaseFirestore fire;

  AccountDetails({required this.fire});

  Future getUserAccountDetails(String uid) async {
    DocumentSnapshot doc = await fire.collection("Users").doc(uid).get();
    return doc;
  }

  Future<String> getUserAccountImage(String uid) async {
    var collection = FirebaseFirestore.instance.collection("Users");
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

  Future<String> sendUpdatedDetails(Uint8List? imagefile, String name,
      String surname, String username, String email) async {
    late String downloadURL;
    User? user = FirebaseAuth.instance.currentUser!;
    if (imagefile != null) {
      final postID = DateTime.now().millisecondsSinceEpoch.toString();

      Reference ref = FirebaseStorage.instance
          .ref()
          .child("${user.uid}/images/profilePicture")
          .child("post_$postID");
      await ref.putData(
          imagefile,
          SettableMetadata(
            cacheControl: "public,max-age=300",
            contentType: "image/jpeg",
          ));
      downloadURL = await ref.getDownloadURL();
    } else {
      await getUserAccountImage(user.uid).then((value) => downloadURL = value);
    }
    String newEmail = Encryption().getEncryptedEmail(email);
    await fire.collection('Users').doc(user.uid).set({
      'name': name,
      'surname': surname,
      'username': username,
      'email': newEmail,
      'uid': user.uid,
      'profilePicture': downloadURL
    });
    await FirebaseAuth.instance.currentUser!.updateEmail(email);
    return "Details Updated";
  }
}
