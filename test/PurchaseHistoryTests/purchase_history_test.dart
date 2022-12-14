import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/purchase_history_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String uid;
  late PurchaseHistoryFunctions pf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    uid = "abc";
    pf = PurchaseHistoryFunctions(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts accordingly when adding items to users purchase history
  test('Add To Purchase History', () async {
    expect(
        await pf.addToOrders([
          {"productID": "productID12", "docID": "docIDabc"},
          {"productID": "productID11", "docID": "docID22"}
        ], uid, "100", "2", "recipientName", "mobileNumber", "complex"),
        "Checkout Successful");
  });
//UNIT TEST
//this test will check that the database acts accordingly when retrieving the purchase history for a user
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
}
