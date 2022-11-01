import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String productID;
  late String uid;
  late String docID;
  late CartFunctions cf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    productID = "123";
    uid = "abc";
    docID = "123abc";
    cf = CartFunctions(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts accordingly to an existing user adding items to their cart
  test('Add To Cart', () async {
    mockFirestore
        .collection('Carts')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .set({"productID": productID, "docID": docID});
    expect(await cf.addToCart(productID, uid, docID), "Added To Cart!");
  });

//UNIT TEST
//this test will check that the database acts accordingly when an existing user purchases an item
  test('Add To Purchase History', () async {
    List itemsInCart = [
      {"productID": productID, "docID": docID},
      {"productID": productID, "docID": docID}
    ];
    mockFirestore
        .collection('PurchaseHistory2')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .set({"productID": productID, "docID": docID});
    expect(
        await cf.addToPurchaseHistory(itemsInCart, uid), "Checkout Successful");
  });

//UNIT TEST
//this test will check that the database acts accordingly to an existing user removing items from their cart when no items are in the cart
  test('Delete From Cart', () async {
    final DocumentReference<Map<String, dynamic>> documentReference =
        mockFirestore
            .collection("Carts")
            .doc(uid)
            .collection("Products")
            .doc(docID);

    await documentReference.set({"productID": productID, "docID": docID});
    String actualResult = await cf.deleteFromCart(productID, uid);
    expect(actualResult, "Deleted");
  });

//UNIT TEST
//this test will check that the database acts accordingly when a cart is being emptied after a purchase
  test('Empty Cart', () async {
    final DocumentReference<Map<String, dynamic>> documentReference =
        mockFirestore
            .collection("Carts")
            .doc(uid)
            .collection("Products")
            .doc(docID);

    await documentReference.set({"productID": productID, "docID": docID});
    String actualResult = await cf.emptyCart(uid);
    expect(actualResult, "Cart Empty");
  });

//UNIT TEST
//this test will check that the database acts accordingly in retrieving an existing users products in cart when the user has no items in cart
  test('Get Products In Cart', () async {
    await mockFirestore.collection("Products").add({
      "category": "electronics",
      "description": "N/A",
      "imageURL": "imageURL",
      "price": "100",
      "productID": productID,
      "productName": "productName",
    });
    await mockFirestore.collection("Products").add({
      "category": "clothing",
      "description": "N/A",
      "imageURL": "imageURL",
      "price": "150",
      "productID": "productID2",
      "productName": "productName",
    });
    await mockFirestore
        .collection("Carts")
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .set({"productID": productID, "docID": docID});
    await mockFirestore
        .collection("Carts")
        .doc(uid)
        .collection("Products")
        .doc("docID2")
        .set({"productID": "productID2", "docID": "docID2"});

    final List<dynamic> dataList = (await cf.getProductsInCart(uid));
    expect(dataList, [
      {
        "category": "electronics",
        "description": "N/A",
        "imageURL": "imageURL",
        "price": "100",
        "productID": productID,
        "productName": "productName",
      },
      {
        "category": "clothing",
        "description": "N/A",
        "imageURL": "imageURL",
        "price": "150",
        "productID": "productID2",
        "productName": "productName",
      }
    ]);
  });
}
