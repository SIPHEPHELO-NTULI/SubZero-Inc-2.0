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
//this test will check that the database acts accordingly when retrieving all the products in the database
  test('Get Products', () async {
    when(mockFirestore.collection("Products").get());
    expect(await fireStoreDataBase.getData(), []);
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving all the suggested products in the database based on the category
  test('Get  Suggested Products', () async {
    when(mockFirestore.collection("Products").get());
    expect(
        await fireStoreDataBase.getSuggestedProducts("electronics", "123"), []);
  });

//UNIT TEST
//this test will check that the database acts accordingly when retrieving all the reviews for a product
  test('Get Product Reviews', () async {
    when(mockFirestore.collection("Products").doc("123").collection("Reviews"));
    expect(await fireStoreDataBase.getProductReviews("123"), []);
  });
}
