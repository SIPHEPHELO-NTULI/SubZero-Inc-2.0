import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/wishlist_functions.dart';
import 'package:mockito/mockito.dart';
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
    when(mockFirestore
        .collection('Wishlists')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .set({"productID": productID, "docID": docID}));
    expect(await cf.addToWishlist(productID, uid, docID), "Added To WishList!");
  });

//UNIT TEST
//this test will check that the database acts accordingly when an existing user purchases an item

//UNIT TEST
//this test will check that the database acts accordingly to an existing user removing items from their cart
  test('Remove From Wishlist', () async {
    when(mockFirestore
        .collection('Wishlists')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .delete());
    expect(await cf.removeFromWishlist(productID, uid), "Deleted");
  });

//UNIT TEST
//this test will check that the database acts accordingly when a cart is being emptied after a purchase
  test('Empty Wishlist', () async {
    when(mockFirestore
        .collection('Wishlists')
        .doc(uid)
        .collection("Products")
        .get());
    expect(await cf.emptyWishlist(uid), "Wishlist Empty");
  });

//UNIT TEST
//this test will check that the database acts accordingly in retrieving an existing users products in cart
  test('Get Products In Wishlist', () async {
    when(mockFirestore
        .collection('Wishlists')
        .doc(uid)
        .collection("Products")
        .get());
    expect(await cf.getProductsInList("Wishlists", uid), []);
  });
}
