import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';

//This class houses the necessary firebase functions related to the wishlist services
//It takes in a required parameter that is instances of firebas, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class WishlistFunctions {
  final FirebaseFirestore fire;

  WishlistFunctions({required this.fire});

  //This function will return the products in the users wishlist

  Future getProductsInWishist(String uid) async {
    final CollectionReference collectionRef =
        fire.collection("Wishlists").doc(uid).collection("Products");
    List itemIDs = [];
    List items = [];
    List itemsInHistoryCart = [];

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
  }

  //This function will add a product to the users wishlist
  //The function will only add it if it is not currently in the wishlist
  //Thus the wishlist contains only unique items
  Future<String> addToWishlist(
      String productID, String uid, String docID) async {
    String result = "Added To WishList!";
    List items = [];
    bool sameProduct = false;
    final CollectionReference collectionRef =
        fire.collection("Wishlists").doc(uid).collection("Products");

    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        items.add(result.data());
      }
    });

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

  //This function will remove a product from the users wishlist
  //Given the productID of the product
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

  //This function will remove a product from the users wishlist
  //Given the productID of the product
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
