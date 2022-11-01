import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/send_product.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late SendProduct cf;
  late String imageURL, price, productName, description, category, productID;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    productName = "productName";
    price = "400";
    imageURL = "imageURL";
    description = "description";
    category = "category";
    productID = "productID";
    cf = SendProduct(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts when a new user creates an account
  test('Add New User', () async {
    await mockFirestore.collection('Products').doc(productID).set({
      'imageURL': imageURL,
      'price': price,
      'productName': productName,
      'category': category,
      'description': description,
      'productID': productID
    });
    expect(
        await cf.uploadProduct(
            price, productName, description, category, productID, imageURL),
        "Product Posted");
  });
}
