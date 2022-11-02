import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/review_functions.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String productID;
  late String orderID;
  late String uid;
  late String text;
  late String recipientname;
  late String mobilenumber;
  late String complexname;
  late String total;
  late String numItems;
  late String purchaseDate;
  late ReviewFunctions rf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    uid = "abc";
    productID = "1232jk3h";
    text = "Good Buy";
    orderID = "123032";
    recipientname = "Ben";
    mobilenumber = "1234567890";
    complexname = "Hills Complex";
    total = "1000";
    numItems = "2";
    purchaseDate = "02-02-2022";

    rf = ReviewFunctions(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts accordingly when a user reviews a product
  test('Upload Comment', () async {
    when(mockFirestore
        .collection('Products')
        .doc(productID)
        .collection('Reviews')
        .doc(uid)
        .set({
      'productID': productID,
      'name': "name",
      'uid': uid,
      'comment': text,
      'date': "date"
    }));
    expect(await rf.uploadReview(productID, text, uid), "Comment Posted");
  });

//UNIT TEST
//this test will check that the function to determine if a user has purchased a product works correctly
//shoudl return true if product was purchased by user
  test('Check Product Purchased returns true', () async {
    await mockFirestore
        .collection("PurchaseHistory")
        .doc(uid)
        .collection("Orders")
        .doc(orderID)
        .set({
      'orderID': orderID,
      'recipientname': recipientname,
      'mobileNumber': mobilenumber,
      'complexname': complexname,
      'uid': uid,
      'total': total,
      'numItems': numItems,
      'purchaseDate': purchaseDate,
      'productIDs': ['abcdef', '1232132', productID]
    });
    expect(await rf.check(productID, uid), true);
  });

//UNIT TEST
//this test will check that the function to determine if a user has purchased a product works correctly
//shoudl return true if product was purchased by user and false otherwise
  test('Check Product Purchased returns false', () async {
    await mockFirestore
        .collection("PurchaseHistory")
        .doc(uid)
        .collection("Orders")
        .doc(orderID)
        .set({
      'orderID': orderID,
      'recipientname': recipientname,
      'mobileNumber': mobilenumber,
      'complexname': complexname,
      'uid': uid,
      'total': total,
      'numItems': numItems,
      'purchaseDate': purchaseDate,
      'productIDs': ['abcdef', '1232132', 'productIDabs']
    });
    expect(await rf.check(productID, uid), false);
  });
}
