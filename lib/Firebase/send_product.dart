import 'package:cloud_firestore/cloud_firestore.dart';

//This class houses the necessary firebase functions related to sending a new product
//It takes in a required parameter that is instances of firebas, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class SendProduct {
  FirebaseFirestore fire;

  SendProduct({required this.fire});

  //This function is used to add a new product to the collections
  //It will be called from the sell screen and use the details entered/
  //by the user. The image is first sent to storage, then the downloadURL
  // is returned and passed to this function
  //the function sends the imageURL,the price, the product name, category
  //and decription as well as a generated productID

  Future uploadProduct(String price, String productName, String description,
      String category, String productID, String downloadURL) async {
    await fire.collection('Products').doc(productID).set({
      'imageURL': downloadURL,
      'price': price,
      'productName': productName,
      'category': category,
      'description': description,
      'productID': productID
    });
    return "Product Posted";
  }
}
