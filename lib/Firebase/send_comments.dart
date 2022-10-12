import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SendComment {
  final FirebaseFirestore fire;

  SendComment({required this.fire});

  Future<String> uploadComment(String prodID, String text, String uid) async {
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
