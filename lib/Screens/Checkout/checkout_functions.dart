import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';
import 'package:give_a_little_sdp/Firebase/credit_functions.dart';
import 'package:give_a_little_sdp/Firebase/purchase_history_functions.dart';

class CheckoutFunctions {
  //This function determines if the user has enough credits to complete their purchase

  bool enoughCredits(String cartTotal, String credits) {
    int cT = int.parse(cartTotal);
    int c = int.parse(credits);
    if (cT > c) {
      return false;
    }
    return true;
  }

  //This function will complete the checkout for the user
  //it will call the necessary functions to empty the cart, and add the products to the
  //purchase history page

  Future<String> checkout(
      List itemsInCart,
      String cartTotal,
      String uid,
      String numItems,
      String recipientName,
      String mobileNumber,
      String complex) async {
    String message = "";
    await CartFunctions(fire: FirebaseFirestore.instance).emptyCart(uid);
    await CreditFunctions(fire: FirebaseFirestore.instance)
        .updateCredits(uid, cartTotal, "-");
    PurchaseHistoryFunctions(fire: FirebaseFirestore.instance)
        .addToOrders(itemsInCart, uid, cartTotal, numItems, recipientName,
            mobileNumber, complex)
        .then((value) => message = value.toString());
    return message;
  }
}
