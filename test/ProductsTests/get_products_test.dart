import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/get_products.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late FireStoreDataBase fireStoreDataBase;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    fireStoreDataBase = FireStoreDataBase(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving all the products in the database when there arent any products
  test('Get Products when no products in database', () async {
    when(mockFirestore.collection("Products").get());
    expect(await fireStoreDataBase.getData(), []);
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving all the products in the database when there are products
  test('Get Products when there are products in database ', () async {
    await mockFirestore.collection("Products").add({
      "category": "electronics",
      "description": "N/A",
      "imageURL": "imageURL",
      "price": "100",
      "productID": "productID",
      "productName": "productName",
    });
    await mockFirestore.collection("Products").add({
      "category": "clothing",
      "description": "N/A",
      "imageURL": "imageURL",
      "price": "150",
      "productID": "productID",
      "productName": "productName",
    });
    final List<dynamic> dataList = (await fireStoreDataBase.getData());

    expect(dataList, [
      {
        "category": "electronics",
        "description": "N/A",
        "imageURL": "imageURL",
        "price": "100",
        "productID": "productID",
        "productName": "productName",
      },
      {
        "category": "clothing",
        "description": "N/A",
        "imageURL": "imageURL",
        "price": "150",
        "productID": "productID",
        "productName": "productName",
      }
    ]);
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving all the suggested products in the database based on the category
  test('Get Suggested Products when no corresponding products in database',
      () async {
    when(mockFirestore.collection("Products").get());
    expect(
        await fireStoreDataBase.getSuggestedProducts("electronics", "123"), []);
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving all the products in the database when there are products
  test('Get Suggested Products when there are products in database', () async {
    await mockFirestore.collection("Products").add({
      "category": "electronics",
      "description": "N/A",
      "imageURL": "imageURL",
      "price": "100",
      "productID": "productID",
      "productName": "productName",
    });
    await mockFirestore.collection("Products").add({
      "category": "electronics",
      "description": "N/A",
      "imageURL": "imageURL",
      "price": "150",
      "productID": "productID2",
      "productName": "productName",
    });
    final List<dynamic> dataList = (await fireStoreDataBase
        .getSuggestedProducts("electronics", "productID"));

    expect(dataList, [
      {
        "category": "electronics",
        "description": "N/A",
        "imageURL": "imageURL",
        "price": "150",
        "productID": "productID2",
        "productName": "productName",
      },
    ]);
  });
//UNIT TEST
//this test will check that the database acts accordingly when retrieving all the reviews for a product
  test('Get Product Reviews when no reviews present', () async {
    when(mockFirestore.collection("Products").doc("123").collection("Reviews"));
    expect(await fireStoreDataBase.getProductReviews("123"), []);
  });

  //UNIT TEST
//this test will check that the database acts accordingly when retrieving all the reviews for a product
  test('Get Product Reviews when there are reviews present', () async {
    await mockFirestore.collection("Products").doc("productID123").set({
      "category": "electronics",
      "description": "N/A",
      "imageURL": "imageURL",
      "price": "100",
      "productID": "productID123",
      "productName": "productName",
    });

    await mockFirestore
        .collection("Products")
        .doc("productID123")
        .collection("Reviews")
        .add({
      "comment": "comment",
      "date": "date",
      "name": "name",
      "productID": "productID123",
      "uid": "uid",
    });
    expect(await fireStoreDataBase.getProductReviews("productID123"), [
      {
        "comment": "comment",
        "date": "date",
        "name": "name",
        "productID": "productID123",
        "uid": "uid",
      }
    ]);
  });
}
