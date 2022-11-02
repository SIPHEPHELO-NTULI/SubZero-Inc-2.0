import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/rating_functions.dart';
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
//this test will check that the database acts accordingly when a user rates a product
  test('Rate Product', () async {
    await mockFirestore
        .collection("PurchasedProducts")
        .doc("orderID")
        .collection("ProductsInOrder")
        .doc("docID")
        .set({
      'orderID': "orderID",
      'productID': productID,
      'productName': "productName",
      'imageURL': "imageURL",
      'price': "price",
      'category': "category",
      'uid': uid,
      'isRated': false,
      'docID': "docID",
    });
    expect(await cf.rateProduct(productID, 5, "docID", "orderID"),
        "Rating Successful");
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving all the ratings for a product
  test('get Product Ratings', () async {
    await mockFirestore.collection("ProductRatings").doc("docID").set({
      'rating': "ratingfromuser",
      'productID': productID,
      'uid': uid,
      'ratingID': "docID"
    });
    expect(await cf.getProductRating(productID), [
      {
        'rating': "ratingfromuser",
        'productID': productID,
        'uid': uid,
        'ratingID': "docID"
      }
    ]);
  });

//UNIT TEST
//this test will check that the database returns the correct number of raters for a product
  test('get Number Of Ratings', () async {
    await mockFirestore.collection("ProductRatings").doc("docID").set({
      'rating': "ratingfromuser",
      'productID': productID,
      'uid': uid,
      'ratingID': "docID"
    });
    expect(await cf.getNumberOfRaters(productID), "1");
  });

//UNIT TEST
//this test will check that the database acts accordingly when calculating the average rating for a product
  test('get Average Rating', () async {
    await mockFirestore.collection("ProductRatings").doc("docID2").set({
      'rating': 2.0,
      'productID': productID,
      'uid': uid,
      'ratingID': "docID2"
    });
    await mockFirestore.collection("ProductRatings").doc("docID").set({
      'rating': 1.0,
      'productID': productID,
      'uid': "123",
      'ratingID': "docID"
    });
    expect(await cf.getAverageRating(productID), "1.5");
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving the purchase history for a user
  test('get Products In Order', () async {
    await mockFirestore
        .collection("PurchasedProducts")
        .doc("historyID")
        .collection("ProductsInOrder")
        .doc("docID")
        .set({
      'orderID': "historyID",
      'productID': productID,
      'productName': "productName",
      'imageURL': "imageURL",
      'price': "price",
      'category': "category",
      'uid': uid,
      'isRated': false,
      'docID': "docID",
    });
    await mockFirestore
        .collection("PurchasedProducts")
        .doc("historyID")
        .collection("ProductsInOrder")
        .doc("docID2")
        .set({
      'orderID': "historyID",
      'productID': "productID2",
      'productName': "productName",
      'imageURL': "imageURL",
      'price': "price",
      'category': "category",
      'uid': uid,
      'isRated': false,
      'docID': "docID2",
    });
    expect(await cf.getProductsInOrder("historyID"), [
      {
        'orderID': "historyID",
        'productID': productID,
        'productName': "productName",
        'imageURL': "imageURL",
        'price': "price",
        'category': "category",
        'uid': uid,
        'isRated': false,
        'docID': "docID",
      },
      {
        'orderID': "historyID",
        'productID': "productID2",
        'productName': "productName",
        'imageURL': "imageURL",
        'price': "price",
        'category': "category",
        'uid': uid,
        'isRated': false,
        'docID': "docID2",
      }
    ]);
  });
}
