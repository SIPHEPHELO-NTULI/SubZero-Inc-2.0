import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class SendComment {
  static Future<String> uploadComment(String prodID, String text) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    String name, surname, finalName;
    var collection = FirebaseFirestore.instance.collection('Users');
    var docSnapshot = await collection.doc(uid).get();

    Map<String, dynamic>? data = docSnapshot.data();
    name = data?['name'];
    surname = data?['surname'];
    finalName = name + " " + surname;
    String date = DateFormat("dd-MMM-yyyy").format(DateTime.now());

    try {
      await FirebaseFirestore.instance
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
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
