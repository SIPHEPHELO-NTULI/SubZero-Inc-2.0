import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

//class used to get list of products from Firebase
//gets the documents as snapshots then adds to the list
//then returns the list
class FireStoreDataBase {
  List products = [];
  final CollectionReference collectionRef =
      FirebaseFirestore.instance.collection("Products");

  Future getData() async {
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
