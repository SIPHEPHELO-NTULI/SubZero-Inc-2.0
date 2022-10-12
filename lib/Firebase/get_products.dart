import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

//class used to get list of products from Firebase
//gets the documents as snapshots then adds to the list
//then returns the list
class FireStoreDataBase {
  final FirebaseFirestore fire;

  FireStoreDataBase({required this.fire});
  Future getData() async {
    final CollectionReference collectionRef = fire.collection("Products");
    List products = [];

    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          products.add(result.data());
        }
      });

      return products;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

//Function used to get a list of suggested products for the user
// the function gets all the products in the collection, then finds the products
//with the same category as the product, the user is viewing
  Future getSuggestedProducts(String category, String productID) async {
    List allProducts = await getData() as List;
    List suggestedProducts = [];
    for (int i = 0; i < allProducts.length; i++) {
      if (allProducts[i]["category"] == category &&
          allProducts[i]["productID"] != productID) {
        suggestedProducts.add(allProducts[i]);
      }
    }
    return suggestedProducts;
  }

  Future getProductReviews(String productID) async {
    final CollectionReference collectionRef =
        fire.collection("Products").doc(productID).collection("Reviews");
    List reviews = [];
    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          reviews.add(result.data());
        }
      });

      return reviews;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}
