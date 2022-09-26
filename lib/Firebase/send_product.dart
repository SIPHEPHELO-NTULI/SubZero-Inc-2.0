import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//This class is used to add a new product to the collections

class SendProduct {
  //It will be called from the sell screen and use the details entered/
//by the user. The image is first sent to storage, then the downloadURL
// is returned and passed to this function
//the function sends the imageURL,the price, the product name, category
//and decription as well as a generated productID
  Future<String> uploadImageToStorage(String image, String price,
      String productName, String description, String category) async {
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
