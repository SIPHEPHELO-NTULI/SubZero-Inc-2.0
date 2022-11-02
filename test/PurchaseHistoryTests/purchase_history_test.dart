import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/purchase_history_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String productID;
  late String uid;
  late PurchaseHistoryFunctions pf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    uid = "abc";
    productID = "1232jk3h";
    pf = PurchaseHistoryFunctions(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts accordingly when adding items to users purchase history
  test('get Orders', () async {
    await mockFirestore
        .collection("PurchaseHistory")
        .doc(uid)
        .collection("Orders")
        .doc("orderID")
        .set({
      'orderID': "orderID",
      'recipientname': "recipientName",
      'mobileNumber': "mobileNumber",
      'complexname': "complex",
      'uid': uid,
      'total': "total",
      'numItems': "numItems",
      'purchaseDate': "purchaseDate",
      'productIDs': "productIDs"
    });
    await mockFirestore
        .collection("PurchaseHistory")
        .doc(uid)
        .collection("Orders")
        .doc("orderID2")
        .set({
      'orderID': "orderID2",
      'recipientname': "recipientName",
      'mobileNumber': "mobileNumber",
      'complexname': "complex",
      'uid': uid,
      'total': "total",
      'numItems': "numItems",
      'purchaseDate': "purchaseDate",
      'productIDs': "productIDs"
    });
    expect(await pf.getOrders(uid), [
      {
        'orderID': "orderID",
        'recipientname': "recipientName",
        'mobileNumber': "mobileNumber",
        'complexname': "complex",
        'uid': uid,
        'total': "total",
        'numItems': "numItems",
        'purchaseDate': "purchaseDate",
        'productIDs': "productIDs"
      },
      {
        'orderID': "orderID2",
        'recipientname': "recipientName",
        'mobileNumber': "mobileNumber",
        'complexname': "complex",
        'uid': uid,
        'total': "total",
        'numItems': "numItems",
        'purchaseDate': "purchaseDate",
        'productIDs': "productIDs"
      }
    ]);
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving the purchase history for a user
}
