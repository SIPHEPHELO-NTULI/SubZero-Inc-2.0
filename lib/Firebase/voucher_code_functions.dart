import 'package:cloud_firestore/cloud_firestore.dart';

//This class houses the necessary firebase functions related to the voucher code services
//It takes in a required parameter that is instances of firebase, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class VoucherCodeFunctions {
  final FirebaseFirestore fire;

  VoucherCodeFunctions({required this.fire});

  Future<String> sendVoucherCode(String vouchercode) async {
    await fire.collection("VoucherCodes").add({"vouchercode": vouchercode});
    return "Success";
  }

  Future<bool> checkCode(String vouchercode) async {
    bool valid = true;
    final CollectionReference collectionRef = fire.collection("VoucherCodes");
    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        if (result["vouchercode"] == vouchercode) {
          valid = false;
        }
      }
    });
    return valid;
  }
}
