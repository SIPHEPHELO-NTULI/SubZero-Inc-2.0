import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/wishlist_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String productID;
  late String uid;
  late String docID;
  late WishlistFunctions cf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    productID = "123";
    uid = "abc";
    docID = "123abc";
    cf = WishlistFunctions(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts accordingly to an existing user adding items to their cart
  test('Add To Wishlists', () async {
    await mockFirestore
        .collection('Wishlists')
        .doc(uid)
        .collection("Products")
        .doc("123232")
        .set({"productID": "123221", "docID": docID});
    expect(await cf.addToWishlist(productID, uid, docID), "Added To WishList!");
  });

//UNIT TEST
//this test will check that the database acts accordingly to an existing user adding items to their cart
  test('Add Same Product To Wishlists', () async {
    await mockFirestore
        .collection('Wishlists')
        .doc(uid)
        .collection("Products")
        .add({"productID": productID, "docID": docID});
    expect(await cf.addToWishlist(productID, uid, "docID2"),
        "Item Already In Wishlist");
  });
//UNIT TEST
//this test will check that the database acts accordingly to an existing user removing items from their cart
  test('Remove From Wishlist', () async {
    await mockFirestore
        .collection('Wishlists')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .set({"productID": productID, "docID": docID});
    expect(await cf.removeFromWishlist(productID, uid), "Deleted");
  });

//UNIT TEST
//this test will check that the database acts accordingly when a cart is being emptied after a purchase
  test('Empty Wishlist', () async {
    await mockFirestore
        .collection('Wishlists')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .set({"productID": productID, "docID": docID});
    expect(await cf.emptyWishlist(uid), "Wishlist Empty");
  });

//UNIT TEST
//this test will check that the database acts accordingly in retrieving an existing users products in cart
  test('Get Products In Wishlist', () async {
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
        .collection("Wishlists")
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .set({"productID": productID, "docID": docID});
    await mockFirestore
        .collection("Wishlists")
        .doc(uid)
        .collection("Products")
        .doc("docID2")
        .set({"productID": "productID2", "docID": "docID2"});

    final List<dynamic> dataList = (await cf.getProductsInWishist(uid));
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
