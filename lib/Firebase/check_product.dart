import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//class used to get list of products from Firebase
//gets the documents as snapshots then adds to the list
//then returns the list
class CheckProduct {
  Future<bool> check(String productID) async {
    bool found = false;
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection("PurchaseHistory2");
    List allpurchases = [];
    try {
      await collectionRef.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          allpurchases.add(result.data());
        }
      });
      for (int i = 0; i < allpurchases.length; i++) {
        if (allpurchases[i]["productID"] == productID &&
            allpurchases[i]["uid"] == uid) {
          found = true;
        }
      }
      return found;
    } catch (e) {
      return found;
    }
  }
}
