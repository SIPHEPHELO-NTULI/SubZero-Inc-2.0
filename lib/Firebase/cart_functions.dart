import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';

//class used to get list of products from Firebase
//gets the documents as snapshots then adds to the list
//then returns the list

class CartFunctions {
  //this function will fetch all the documents in the Carts collection
  //in the firestore database
  // it then iterates through those documents to find all the products in
  // the signed in user's cart
  static Future getProductsInCart() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    final CollectionReference collectionRef = FirebaseFirestore.instance
        .collection("Carts")
        .doc(uid)
        .collection("Products");
    List itemIDs = [];
    List items = [];
    List itemsInCart = [];

    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          itemIDs.add(result.data());
        }
      });
      items = await FireStoreDataBase.getData() as List;

      for (int i = 0; i < itemIDs.length; i++) {
        for (int j = 0; j < items.length; j++) {
          if (itemIDs[i]["productID"].toString() ==
              items[j]["productID"].toString()) {
            itemsInCart.add(items[j]);
          }
        }
      }

      return itemsInCart;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

//function to add products to users cart in firestore datase Carts
// it will store the products in a document named after the users
//uid then creates a subsection populated with the productID for each product
//in the car
  Future<String> addToCart(String productID) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    String docID = FirebaseFirestore.instance.collection("Carts").doc().id;
    try {
      await FirebaseFirestore.instance
          .collection('Carts')
          .doc(uid)
          .collection("Products")
          .doc(docID)
          .set({"productID": productID, "docID": docID});
      return "Added To Cart!";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

//function to removes products from users cart in firestore datase Carts
// it will fetch all the documents in the cart database
//it will then find the cart related to the signed in user
//it then finds the product to delete using the productID
//and deleted the document
  Future<String> deleteFromCart(String productID) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    List itemIDs = [];
    String docID = "";
    final CollectionReference collectionRef = FirebaseFirestore.instance
        .collection("Carts")
        .doc(uid)
        .collection("Products");

    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        itemIDs.add(result.data());
      }
    });
    for (int i = 0; i < itemIDs.length; i++) {
      if (itemIDs[i]["productID"] == productID) {
        docID = itemIDs[i]["docID"];
        break;
      }
    }
    try {
      await FirebaseFirestore.instance
          .collection('Carts')
          .doc(uid)
          .collection("Products")
          .doc(docID)
          .delete();
      return "Deleted";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
