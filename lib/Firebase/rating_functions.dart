import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class RatingFunctions {
  final FirebaseFirestore fire;

  RatingFunctions({required this.fire});

  //this funtion takes productID
  //and returns the ratings of that product.
  Future getProductRating(String productID) async {
    final CollectionReference collectionRef = fire.collection("ProductRating");
    List allproductsRatings = [];
    List productRatings = [];
    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          allproductsRatings.add(result.data());
        }
      });
      for (int i = 0; i < allproductsRatings.length; i++) {
        if (allproductsRatings[i]["productID"] == productID) {
          productRatings.add(allproductsRatings[i]);
        }
      }
      return productRatings;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  //write test
  Future<String> getNumberOfRaters(String productID) async {
    List productRatings = await getProductRating(productID) as List;
    int numberOfRaters = productRatings.length;
    return numberOfRaters.toString();
  }

  Future<String> getAverageRating(String productID) async {
    List productRatings = await getProductRating(productID) as List;
    double total = 0;
    String average = "0";
    for (int i = 0; i < productRatings.length; i++) {
      total = total + productRatings[i]['rating'];
    }
    if (productRatings.isEmpty) {
      return average;
    } else {
      average = (total / productRatings.length).toString();
      return average;
    }
  }

  // ignore: non_constant_identifier_names
  Future getProductsIn_History(String collectionName, String uid) async {
    final CollectionReference collectionRef = fire.collection(collectionName);
    List products = [];
    List itemsInHistoryCart = [];
    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          products.add(result.data());
        }
      });
      for (int i = 0; i < products.length; i++) {
        if (products[i]["uid"] == uid) {
          itemsInHistoryCart.add(products[i]);
        }
      }
      return itemsInHistoryCart;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }
}
