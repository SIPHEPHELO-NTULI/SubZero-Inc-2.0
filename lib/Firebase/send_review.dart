import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

//This class houses the necessary firebase functions related to the review services
//It takes in a required parameter that is instances of firebas, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class SendReview {
  final FirebaseFirestore fire;

  SendReview({required this.fire});

  //This function will upload a users review
  //It will use the uid to get the users name and surname
  //then send those details along with the review
  //to the Reviews subcollection in the Products Collection

  Future<String> uploadReview(String prodID, String text, String uid) async {
    String name = "", surname = "", finalName = "";
    var collection = fire.collection('Users');
    var docSnapshot = await collection.doc(uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      name = data?['name'];
      surname = data?['surname'];
      finalName = name + " " + surname;
    }
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
}
