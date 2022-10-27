import 'package:cloud_firestore/cloud_firestore.dart';

//This class houses the necessary firebase functions related to the cart and history services
//It takes in a required parameter that is instances of firebase, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class CheckProduct {
  final FirebaseFirestore fire;

  CheckProduct({required this.fire});

  //The check function will determine if the user has purchased the relevant product
  //it returns a boolean value
  //should the value be true, the user will be able to review the item
  //if they have not purchased it, they wont be able to review it

  Future<bool> check(String productID, String uid) async {
    bool found = false;
    final CollectionReference collectionRef =
        fire.collection("PurchaseHistory2");
    List allpurchases = [];

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
  }
}
