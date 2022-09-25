import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendProduct {
  Future<String> uploadImageToStorage(String image, String price,
      String productName, String description, String category) async {
    String downloadURL;
    String productID =
        FirebaseFirestore.instance.collection("Products").doc().id;
    if (description == "") {
      description = "N/A";
    }
    try {
      FirebaseFirestore.instance.collection('Products').doc(productID).set({
        'imageURL': image,
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
