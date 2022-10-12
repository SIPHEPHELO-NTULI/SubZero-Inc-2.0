import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//class used to get list of products from Firebase
//gets the documents as snapshots then adds to the list
//then returns the list
class CheckProduct {
  Future<bool> check(String productID) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    bool found = false;
    final CollectionReference collectionRef = FirebaseFirestore.instance
        .collection("PurchaseHistory2")
        .doc(uid)
        .collection("Products");
    List products = [];

    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        products.add(result.data());
      }
    });

    for (int i = 0; i < products.length; i++) {
      if (products[i]["productID"] == productID) {
        found = true;
      }
    }

    return found;
  }
}
