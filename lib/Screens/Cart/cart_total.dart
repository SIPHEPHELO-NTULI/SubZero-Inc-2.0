//This class is used to get the total for the items in the cart/
//it takes in a list of items that was retrieved from the database
//it then iterates through the list and finds the price of each item
// it converts the price to an integer so it can be added to the totalCost
//once all items have been read, the total is returned as a string

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
