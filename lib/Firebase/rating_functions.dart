import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

//This class houses the necessary firebase functions related to the retrieving information about the ratings
//It takes in a required parameter that is instances of firebas, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class RatingFunctions {
  final FirebaseFirestore fire;

  RatingFunctions({required this.fire});

  //this function takes productID
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

  //this function will determine the number of users that rated a product
  //it will use the product id to retrive a list of ratings
  //it then determines the length of the list and returns that
  //as a string

  Future<String> getNumberOfRaters(String productID) async {
    List productRatings = await getProductRating(productID) as List;
    int numberOfRaters = productRatings.length;
    return numberOfRaters.toString();
  }

  //this function will determine the average rating for a product
  //it will use the above getProductRating function to get all the ratings
  //then determines the average rating

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

  //this function will get all the previously purchased items for the user
  //and return them as a list or return null if they have not purchased any items

  Future getProductsInHistory(String collectionName, String uid) async {
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
