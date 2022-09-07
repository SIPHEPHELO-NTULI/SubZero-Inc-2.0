import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class SendProduct {
  Future<String> uploadImageToStorage(Uint8List imagefile, String price,
      String productName, String description) async {
    String downloadURL;
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("$uid/images")
          .child("post_$postID");
      await ref.putData(imagefile);
      downloadURL = await ref.getDownloadURL();
      FirebaseFirestore.instance.collection('Products').doc(uid).set({
        'imageURL':
            "https://images.pexels.com/photos/2783873/pexels-photo-2783873.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        'price': price,
        'productName': productName,
        'category': "other",
        'description': description
      });
      return "Product Posted";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
