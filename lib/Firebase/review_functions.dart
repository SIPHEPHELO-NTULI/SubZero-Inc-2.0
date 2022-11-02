import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

//This class houses the necessary firebase functions related to the review services
//It takes in a required parameter that is instances of firebas, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class ReviewFunctions {
  final FirebaseFirestore fire;

  ReviewFunctions({required this.fire});

  //This function will upload a users review
  //It will use the uid to get the users name and surname
  //then send those details along with the review
  //to the Reviews subcollection in the Products Collection

  Future<String> uploadReview(String prodID, String text, String uid) async {
    String name = "", surname = "", finalName = "";
    var collection = fire.collection('Users');
    var docSnapshot = await collection.doc(uid).get();

    Map<String, dynamic>? data = docSnapshot.data();
    name = data?['name'];
    surname = data?['surname'];
    finalName = name + " " + surname;

    String date = DateFormat("dd-MMM-yyyy").format(DateTime.now());

    await fire
        .collection('Products')
        .doc(prodID)
        .collection('Reviews')
        .doc(uid)
        .set({
      'productID': prodID,
      'name': finalName,
      'uid': uid,
      'comment': text,
      'date': date
    });

    return "Comment Posted";
  }

  //The check function will determine if the user has purchased the relevant product
  //it returns a boolean value
  //should the value be true, the user will be able to review the item
  //if they have not purchased it, they wont be able to review it

  Future<bool> check(String productID, String uid) async {
    bool found = false;
    final CollectionReference collectionRef =
        fire.collection("PurchaseHistory").doc(uid).collection("Orders");
    List allpurchases = [];
    List productIDs;
    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        allpurchases.add(result.data());
      }
    });
    for (int i = 0; i < allpurchases.length; i++) {
      productIDs = allpurchases[i]["productIDs"] as List;
      for (int j = 0; j < productIDs.length; j++) {
        if (productIDs[j] == productID) {
          found = true;
        }
      }
    }
    return found;
  }
}
