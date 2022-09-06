import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

//class used to get list of products from Firebase
//gets the documents as snapshots then adds to the list
//then returns the list
class FireStoreDataBase {
  static Future getData() async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("Products");
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
}
