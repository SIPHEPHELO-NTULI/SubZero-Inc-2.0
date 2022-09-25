import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Cart/cart_total.dart';

void main() {
  test('Cart total returns 150 when given 100 and 50', () {
    List items = [
      {'price': '100'},
      {'price': '50'}
    ];
    final cartTotal = CartTotal();
    expect(cartTotal.getCartTotal(items), "150");
  });

  test('Cart total returns 150 when given 100 and 50', () {
    List items = [
      {'price': '100'},
      {'price': '50'}
    ];
    final cartTotal = CartTotal();
    expect(cartTotal.getCartTotal(items), "150");
  });
}
