import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/pricevalidator.dart';
//import 'package:test';

void main() {
  test('empty price returns error string', () async {
    var result = PriceValidator.validate('');
    expect(result, "Price cannot be empty");
  });
}
