import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreditFunctions {
  Future<String> updateCredits(String balance, String sign) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    var collection = FirebaseFirestore.instance.collection('Credits');
    var docSnapshot = await collection.doc(uid).get();

    int currentTotal = 0;
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      int value = data?['balance'];
      currentTotal = currentTotal + value;
    }

    int b = int.parse(balance);
    if (sign == "+") {
      currentTotal = currentTotal + b;
    } else {
      currentTotal = currentTotal - b;
    }

    try {
      await FirebaseFirestore.instance
          .collection('Credits')
          .doc(uid)
          .set({"balance": currentTotal});
      return "Balance Updated!";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<String> getCurrentBalance() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    var collection = FirebaseFirestore.instance.collection('Credits');
    var docSnapshot = await collection.doc(uid).get();
    String total = "";
    int currentBalance = 0;
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      int value = data?['balance'];
      currentBalance = currentBalance + value;
    }
    total = currentBalance.toString();
    return total;
  }
}