class CartTotal {
  String getCartTotal(List itemsInCart) {
    int totalInt = 0;
    String total = "";
    for (int i = 0; i < itemsInCart.length; i++) {
      int temp = int.parse(itemsInCart[i]["price"]);
      totalInt = totalInt + temp;
    }
    total = totalInt.toString();
    return total;
  }
}
