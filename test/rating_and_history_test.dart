import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/rating_functions.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String productID;
  late String historyID;
  late String uid;
  late double ratingFromUser;
  late String docID;
  late RatingFunctions cf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    uid = "abc";
    productID = "1232jk3h";
    historyID = "sdsfdsfdf";
    ratingFromUser = 2;
    docID = "0qmvcQsLd3TmwB08RqvF";
    cf = RatingFunctions(fire: mockFirestore);
  });

  test('get Product Rating', () async {
    when(mockFirestore.collection("ProductRating").get());
    expect(await cf.getProductRating(productID), []);
  });

  test('get Average Rating', () async {
    when(mockFirestore.collection("ProductRating").get());
    expect(await cf.getAverageRating(productID), "0");
  });

  test('get Products In Hisory', () async {
    when(mockFirestore.collection("PurchaseHistory").get());
    expect(await cf.getProductsIn_History("PurchaseHistory", uid), []);
  });
}
