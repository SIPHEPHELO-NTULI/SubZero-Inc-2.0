import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/review_functions.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String productID;
  late String uid;
  late String text;
  late ReviewFunctions cf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    uid = "abc";
    productID = "1232jk3h";
    text = "Good Buy";
    cf = ReviewFunctions(fire: mockFirestore);
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
    expect(await cf.uploadReview(productID, text, uid), "Comment Posted");
  });

//UNIT TEST
//this test will check that the function to determine if a user has purchased a product works correctly
//shoudl return true if product was purchased by user
  test('Check Product Purchased returns true', () async {
    await mockFirestore.collection("PurchaseHistory2").doc("historyID").set({
      'productName': "productName",
      'imageURL': "imageURL",
      'price': "price",
      'category': "category",
      'historyID': "historyID",
      'productID': productID,
      'uid': uid,
      'isRated': false
    });
    expect(await cf.check(productID, uid), true);
  });

//UNIT TEST
//this test will check that the function to determine if a user has purchased a product works correctly
//shoudl return true if product was purchased by user and false otherwise
  test('Check Product Purchased returns false', () async {
    await mockFirestore.collection("PurchaseHistory2").doc("historyID").set({
      'productName': "productName",
      'imageURL': "imageURL",
      'price': "price",
      'category': "category",
      'historyID': "historyID",
      'productID': "productID2",
      'uid': uid,
      'isRated': false
    });
    expect(await cf.check(productID, uid), false);
  });
}
