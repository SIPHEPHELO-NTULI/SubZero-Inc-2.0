import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

//This class is used to add a new product to the collections

class SendProduct {
  //It will be called from the sell screen and use the details entered/
//by the user. The image is first sent to storage, then the downloadURL
// is returned and passed to this function
//the function sends the imageURL,the price, the product name, category
//and decription as well as a generated productID

  Future uploadImage(Uint8List imagefile, String price, String productName,
      String description, String category) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final postID = DateTime.now().millisecondsSinceEpoch.toString();
    String productID =
        FirebaseFirestore.instance.collection("Products").doc().id;

    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${uid}/images")
        .child("post_$postID");
    await ref.putData(
        imagefile,
        SettableMetadata(
          cacheControl: "public,max-age=300",
          contentType: "image/jpeg",
        ));

    String downloadURL = await ref.getDownloadURL();

    if (description == "") {
      description = "N/A";
    }
    try {
      await FirebaseFirestore.instance
          .collection('Products')
          .doc(productID)
          .set({
        'imageURL': downloadURL,
        'price': price,
        'productName': productName,
        'category': category,
        'description': description,
        'productID': productID
      });
      return "Product Posted";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
