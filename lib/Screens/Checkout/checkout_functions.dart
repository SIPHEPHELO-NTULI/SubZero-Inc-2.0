class CheckoutFunctions {
  bool enoughCredits(String cartTotal, String credits) {
    int cT = int.parse(cartTotal);
    int c = int.parse(credits);
    if (cT > c) {
      return false;
    }
    return true;
  }
}
