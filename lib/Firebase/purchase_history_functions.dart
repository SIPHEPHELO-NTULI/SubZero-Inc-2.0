import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PurchaseHistoryFunctions {
  final FirebaseFirestore fire;

  PurchaseHistoryFunctions({required this.fire});

  //This function is used when a user has checked out, the products they have  purchased will be added to the collection

  Future<String> addToOrders(
      List itemsInCart,
      String uid,
      String total,
      String numItems,
      String recipientName,
      String mobileNumber,
      String complex) async {
    List productIDs = [];
    String purchaseDate = DateFormat("dd-MMM-yyyy").format(DateTime.now());
    String orderID = fire
        .collection("PurchaseHistory")
        .doc(uid)
        .collection("Orders")
        .doc()
        .id;

    for (var product in itemsInCart) {
      String docID = fire
          .collection("PurchasedProducts")
          .doc(orderID)
          .collection("ProductsInOrder")
          .doc()
          .id;
      await fire
          .collection("PurchasedProducts")
          .doc(orderID)
          .collection("ProductsInOrder")
          .doc(docID)
          .set({
        'orderID': orderID,
        'productID': product["productID"],
        'productName': product["productName"],
        'imageURL': product["imageURL"],
        'price': product["price"],
        'category': product["category"],
        'uid': uid,
        'isRated': false,
        'docID': docID,
      });
      productIDs.add(product["productID"]);
    }
    await fire
        .collection("PurchaseHistory")
        .doc(uid)
        .collection("Orders")
        .doc(orderID)
        .set({
      'orderID': orderID,
      'recipientname': recipientName,
      'mobileNumber': mobileNumber,
      'complexname': complex,
      'uid': uid,
      'total': total,
      'numItems': numItems,
      'purchaseDate': purchaseDate,
      'productIDs': productIDs
    });

    return "Checkout Successful";
  }

  //this function will get all the previously purchased items for the user
  //and return them as a list or return null if they have not purchased any items

  Future getOrders(String uid) async {
    final CollectionReference collectionRef =
        fire.collection("PurchaseHistory").doc(uid).collection("Orders");
    List products = [];

    await collectionRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        products.add(result.data());
      }
    });
    return products;
  }
}
