import 'package:cloud_firestore/cloud_firestore.dart';

//This class houses the necessary firebase functions related to the credit services
//It takes in a required parameter that is instances of firebase, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class CreditFunctions {
  final FirebaseFirestore fire;

  CreditFunctions({required this.fire});

  //This will increase the current users credit balance if they have redeemed a voucher code
  //It is also used to decrease their account balance if they purchased products
  //This is handled by passing a string containing the operation to be performed
  //The function will return a string

  Future<String> updateCredits(String uid, String balance, String sign) async {
    var collection = fire.collection('Credits');
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

    await fire.collection('Credits').doc(uid).set({"balance": currentTotal});
    return "Balance Updated!";
  }

  //This function is used to retrieve the current balance
  //It is used to display the credits in the appbar
  //as well as to check if the user has enough credits to purchase an item

  Future<String> getCurrentBalance(String uid) async {
    var collection = fire.collection('Credits');
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
