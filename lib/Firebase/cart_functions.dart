import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';

//class used to get list of products from Firebase
//gets the documents as snapshots then adds to the list
//then returns the list
class CartHistoryFunctions {
  final FirebaseFirestore fire;

  CartHistoryFunctions({required this.fire});

  Future getProductsInCartHistory(String collectionName, String uid) async {
    final CollectionReference collectionRef =
        fire.collection(collectionName).doc(uid).collection("Products");
    List itemIDs = [];
    List items = [];
    List itemsInHistoryCart = [];

    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          itemIDs.add(result.data());
        }
      });
      items = await FireStoreDataBase(fire: fire).getData() as List;

      for (int i = 0; i < itemIDs.length; i++) {
        for (int j = 0; j < items.length; j++) {
          if (itemIDs[i]["productID"].toString() ==
              items[j]["productID"].toString()) {
            itemsInHistoryCart.add(items[j]);
          }
        }
      }

      return itemsInHistoryCart;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<String> addToPurchaseHistory(List itemsInCart, String uid) async {
    for (var productID in itemsInCart) {
      String historyID = fire.collection("PurchaseHistory2").doc().id;
      try {
        fire.collection("PurchaseHistory2").doc(historyID).set({
          'productName': productID["productName"],
          'imageURL': productID["imageURL"],
          'price': productID["price"],
          'category': productID["category"],
          'historyID': historyID,
          'productID': productID["productID"],
          'uid': uid,
          'isRated': false
        });
      } on FirebaseAuthException catch (e) {
        return e.message.toString();
      }
    }

    return "Checkout Successful";
  }

  Future<String> addToCart(String productID, String uid, String docID) async {
    String result = "Added To Cart!";
    try {
      await fire
          .collection('Carts')
          .doc(uid)
          .collection("Products")
          .doc(docID)
          .set({"productID": productID, "docID": docID});
      return result;
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> deleteFromCart(String productID, String uid) async {
    List itemIDs = [];
    String docID = "";
    final CollectionReference collectionRef =
        fire.collection("Carts").doc(uid).collection("Products");

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
      await fire
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

  Future<String> emptyCart(String uid) async {
    var collection = fire.collection('Carts').doc(uid).collection("Products");
    var snapshots = await collection.get();

    try {
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }

      return "Cart Empty";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
