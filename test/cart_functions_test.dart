import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';
import 'package:mockito/mockito.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  late FakeFirebaseFirestore mockFirestore;
  late String productID;
  late String uid;
  late String docID;
  late CartHistoryFunctions cf;
  setUp(() {
    mockFirestore = FakeFirebaseFirestore();
    productID = "123";
    uid = "abc";
    docID = "123abc";
    cf = CartHistoryFunctions(fire: mockFirestore);
  });

//UNIT TEST
//this test will check that the database acts accordingly to an existing user adding items to their cart
  test('Add To Cart', () async {
    when(mockFirestore
        .collection('Carts')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .set({"productID": productID, "docID": docID}));
    expect(await cf.addToCart(productID, uid, docID), "Added To Cart!");
  });

//UNIT TEST
//this test will check that the database acts accordingly when an existing user purchases an item
  test('Add To Purchase History', () async {
    List itemsInCart = [
      {"productID": productID, "docID": docID},
      {"productID": productID, "docID": docID}
    ];
    when(mockFirestore
        .collection('PurchaseHistory2')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .set({"productID": productID, "docID": docID}));
    expect(
        await cf.addToPurchaseHistory(itemsInCart, uid), "Checkout Successful");
  });

//UNIT TEST
//this test will check that the database acts accordingly to an existing user removing items from their cart
  test('Delete From Cart', () async {
    when(mockFirestore
        .collection('Carts')
        .doc(uid)
        .collection("Products")
        .doc(docID)
        .delete());
    expect(await cf.deleteFromCart(productID, uid), "Deleted");
  });

//UNIT TEST
//this test will check that the database acts accordingly when a cart is being emptied after a purchase
  test('Empty Cart', () async {
    when(mockFirestore
        .collection('Carts')
        .doc(uid)
        .collection("Products")
        .get());
    expect(await cf.emptyCart(uid), "Cart Empty");
  });

//UNIT TEST
//this test will check that the database acts accordingly in retrieving an existing users products in cart
  test('Get Products In Cart', () async {
    when(mockFirestore
        .collection('Carts')
        .doc(uid)
        .collection("Products")
        .get());
    expect(await cf.getProductsInCartHistory("Carts", uid), []);
  });
}
