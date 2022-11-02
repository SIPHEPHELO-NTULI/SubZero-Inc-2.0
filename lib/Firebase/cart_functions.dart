import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';

//This class houses the necessary firebase functions related to the cart and history services
//It takes in a required parameter that is instances of firebase, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class CartFunctions {
  final FirebaseFirestore fire;

  CartFunctions({required this.fire});

  ///This function get a list of all the products in the users carts or purchase history depending on the collection name
  ///if the collection name is Carts, it will return the current products in the users cart
  ///if the collection name is PurchaseHistory, it will return the past products the user has purchased

  Future getProductsInCart(String uid) async {
    final CollectionReference collectionRef =
        fire.collection("Carts").doc(uid).collection("Products");
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

  //This function is used when a user has added an item to their cart
  //this is a subcollection in the Carts collection that is linked to the users uid

  Future<String> addToCart(String productID, String uid, String docID) async {
    String result = "Added To Cart!";

    await fire
        .collection('Carts')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .set({"productID": productID, "docID": docID});
    return result;
  }

  //This function is used when a user has removed an item from their cart
  //this takens in the productID of the product and will loop through
  //the items in the cart and find the matching product then remove it

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
    await fire
        .collection('Carts')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .delete();
    return "Deleted";
  }

  //This function is used when a user has checkedout
  //this takens in the uid and will remove all the items in the cart

  Future<String> emptyCart(String uid) async {
    var collection = fire.collection('Carts').doc(uid).collection("Products");
    var snapshots = await collection.get();

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }

    return "Cart Empty";
  }
}
