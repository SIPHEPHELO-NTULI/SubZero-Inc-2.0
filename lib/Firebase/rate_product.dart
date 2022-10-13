import 'package:cloud_firestore/cloud_firestore.dart';

class RateProduct {
  final FirebaseFirestore fire;

  RateProduct({required this.fire});

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
