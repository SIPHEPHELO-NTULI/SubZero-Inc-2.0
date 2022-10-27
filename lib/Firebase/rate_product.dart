import 'package:cloud_firestore/cloud_firestore.dart';

//This class houses the necessary firebase functions related to the rating services
//It takes in a required parameter that is instances of firebas, FirebaseFirestore.instance

class RateProduct {
  final FirebaseFirestore fire;

  RateProduct({required this.fire});

  //This function will send a users rating to the productRating collection
  //it will also adjust the isRated variable in the PurchaseHistory collection
  //this is to ensure a user can only rate a purchased product one

  Future<String> rateProduct(String productID, double ratingfromuser,
      String historyID, String uid) async {
    String docID = fire.collection("ProductRating").doc().id;

    await fire.collection("ProductRating").doc(docID).set({
      'rating': ratingfromuser,
      'productID': productID,
      'uid': uid,
      'ratingID': docID
    }).whenComplete(() {
      fire
          .collection("PurchaseHistory2")
          .doc(historyID)
          .update({'isRated': true});
    });

    return "Rating Successful";
  }
}
