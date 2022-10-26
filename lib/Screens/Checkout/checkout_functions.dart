import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:give_a_little_sdp/Firebase/cart_functions.dart';
import 'package:give_a_little_sdp/Firebase/credit_functions.dart';

class CheckoutFunctions {
  bool enoughCredits(String cartTotal, String credits) {
    int cT = int.parse(cartTotal);
    int c = int.parse(credits);
    if (cT > c) {
      return false;
    }
    return true;
  }

  Future<String> checkout(
      List itemsInCart, String cartTotal, String uid) async {
    String message = "";
    await CartHistoryFunctions(fire: FirebaseFirestore.instance).emptyCart(uid);
    await CreditFunctions(fire: FirebaseFirestore.instance)
        .updateCredits(uid, cartTotal, "-");
    CartHistoryFunctions(fire: FirebaseFirestore.instance)
        .addToPurchaseHistory(itemsInCart, uid)
        .then((value) => message = value.toString());
    return message;
  }
}
