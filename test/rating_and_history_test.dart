import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/rating_functions.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String productID;
  late String uid;
  late RatingFunctions cf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    uid = "abc";
    productID = "1232jk3h";
    cf = RatingFunctions(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving all the ratings for a product
  test('get Product Ratings', () async {
    when(mockFirestore.collection("ProductRating").get());
    expect(await cf.getProductRating(productID), []);
  });

//UNIT TEST
//this test will check that the database returns the correct number of raters for a product
  test('get Number Of Ratings', () async {
    when(mockFirestore.collection("ProductRating").get());
    expect(await cf.getNumberOfRaters(productID), "0");
  });

//UNIT TEST
//this test will check that the database acts accordingly when calculating the average rating for a product
  test('get Average Rating', () async {
    when(mockFirestore.collection("ProductRating").get());
    expect(await cf.getAverageRating(productID), "0");
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving the purchase history for a user
  test('get Products In Hisory', () async {
    when(mockFirestore.collection("PurchaseHistory").get());
    expect(await cf.getProductsIn_History("PurchaseHistory", uid), []);
  });
}
