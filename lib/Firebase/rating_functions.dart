import 'package:cloud_firestore/cloud_firestore.dart';

//This class houses the necessary firebase functions related to the retrieving information about the ratings
//It takes in a required parameter that is instances of firebas, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class RatingFunctions {
  final FirebaseFirestore fire;

  RatingFunctions({required this.fire});

//This function will send a users rating to the productRating collection
  //it will also adjust the isRated variable in the PurchaseHistory collection
  //this is to ensure a user can only rate a purchased product one

  Future<String> rateProduct(String productID, double ratingfromuser,
      String docID, String orderID) async {
    await fire.collection("ProductRatings").add({
      'rating': ratingfromuser,
      'productID': productID,
    }).whenComplete(() {
      fire
          .collection("PurchasedProducts")
          .doc(orderID)
          .collection("ProductsInOrder")
          .doc(docID)
          .update({'isRated': true});
    });

    return "Rating Successful";
  }

  //this function takes productID
  //and returns the ratings of that product.

  Future getProductRating(String productID) async {
    final CollectionReference collectionRef = fire.collection("ProductRatings");
    List allproductsRatings = [];
    List productRatings = [];

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

  Future getProductsInOrder(String orderID) async {
    final CollectionReference collectionRef = fire
        .collection("PurchasedProducts")
        .doc(orderID)
        .collection("ProductsInOrder");
    List products = [];

    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        products.add(result.data());
      }
    });
    return products;
  }
}
