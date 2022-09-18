import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SendProduct {
  Future<String> uploadImageToStorage(String price, String productName,
      String description, String category) async {
    String downloadURL;
    String productID =
        FirebaseFirestore.instance.collection("Products").doc().id;
    if (description == "") {
      description = "N/A";
    }
    try {
      /*  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("$uid/images")
          .child("post_$postID");
      await ref.putData(imagefile);
      downloadURL = await ref.getDownloadURL(); */
      FirebaseFirestore.instance.collection('Products').doc(productID).set({
        'imageURL':
            "https://images.pexels.com/photos/2783873/pexels-photo-2783873.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
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
