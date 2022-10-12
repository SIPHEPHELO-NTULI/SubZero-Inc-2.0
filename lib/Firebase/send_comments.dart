import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class SendComment {
  static Future uploadComment(String prodID, String text) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    late var name;
    var collection = FirebaseFirestore.instance.collection('Users');
    var docSnapshot = await collection.doc(uid).get();

    Map<String, dynamic>? data = docSnapshot.data();
    name = data?['username']; // <-- The value you want to retrieve.
    // Call setState if needed.

    try {
      await FirebaseFirestore.instance
          .collection('Products')
          .doc(prodID)
          .collection("reviews")
          .doc(uid)
          .set({
        'productID': prodID,
        'Username': name,
        'Uid': uid,
        'comments': text
      });

      return "comment Posted";
    }

    // ignore: empty_catches
    on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
