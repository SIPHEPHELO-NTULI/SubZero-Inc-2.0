import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';

//class used to get list of products from Firebase
//gets the documents as snapshots then adds to the list
//then returns the list
class WishlistFunctions {
  final FirebaseFirestore fire;

  WishlistFunctions({required this.fire});

  Future getProductsInList(String collectionName, String uid) async {
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

  Future<String> addToWishlist(
      String productID, String uid, String docID) async {
    String result = "Added To WishList!";
    List items = [];
    bool sameProduct = false;
    await getProductsInList("Wishlists", uid).then((value) => items = value);

    for (int i = 0; i < items.length; i++) {
      if (items[i]["productID"] == productID) {
        sameProduct = true;
        break;
      }
    }
    if (sameProduct == false) {
      await fire
          .collection('Wishlists')
          .doc(uid)
          .collection("Products")
          .doc(docID)
          .set({"productID": productID, "docID": docID});
      return result;
    }
    return "Item Already In Wishlist";
  }

  Future<String> removeFromWishlist(String productID, String uid) async {
    List itemIDs = [];
    String docID = "";
    final CollectionReference collectionRef =
        fire.collection("Wishlists").doc(uid).collection("Products");

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
    await fire
        .collection('Wishlists')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .delete();
    return "Deleted";
  }

  Future<String> emptyWishlist(String uid) async {
    var collection =
        fire.collection('Wishlists').doc(uid).collection("Products");
    var snapshots = await collection.get();

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }

    return "Wishlist Empty";
  }
}
