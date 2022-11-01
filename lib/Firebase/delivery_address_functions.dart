import 'package:cloud_firestore/cloud_firestore.dart';

//This class houses the necessary firebase functions related to the delivery address services
//It takes in a required parameter that is instances of firebase, FirebaseFirestore.instance
//in the case of testing it will take MockFirebaseFirestore.instance

class DeliveryAdressFunctions {
  final FirebaseFirestore fire;
  DeliveryAdressFunctions({required this.fire});

  // this function takes delivery data from user and post it on the database

  Future<String> addDeliveryAdress(
      String recipientname,
      String mobilenumber,
      String complexname,
      String streetaddress,
      String suburbname,
      String province,
      String city,
      String uid) async {
    String docID = fire.collection("DeliveryAddress").doc().id;
    await fire.collection("DeliveryAddress").doc(docID).set({
      'recipientname': recipientname,
      'mobilenumber': mobilenumber,
      'complexname': complexname,
      'streetaddress': streetaddress,
      'suburb': suburbname,
      'province': province,
      'city': city,
      'uid': uid,
      'docID': docID
    });
    return "Address added";
  }

  // this function retuns all the delivery address saved by the user.

  Future getDeliveryAddress(String uid) async {
    final CollectionReference collectionRef =
        fire.collection('DeliveryAddress');
    List deliveryAddresses = [];
    List userdeliveryAddress = [];
    await collectionRef.get().then((querySnapshot) {
      //get all the delivery address in the database.
      for (var result in querySnapshot.docs) {
        deliveryAddresses.add(result.data());
      }
    });

    //get all the delivery addresses for the user.
    for (int i = 0; i < deliveryAddresses.length; i++) {
      if (deliveryAddresses[i]["uid"] == uid) {
        userdeliveryAddress.add(deliveryAddresses[i]);
      }
    }
    return userdeliveryAddress;
  }

  //delete a  delivery addresses for the user using its docID.

  Future<String> deleteAddress(String docID) async {
    await fire.collection("DeliveryAddress").doc(docID).delete();
    return "Addresss Deleted";
  }
}
