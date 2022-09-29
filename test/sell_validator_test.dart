import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/pricevalidator.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/productNameValidator.dart';

//UNIT TEST
//this test will check that price validator correctly validates an empty price
void main() {
  test('empty price returns error string', () async {
    var result = PriceValidator.validate('');
    expect(result, "Price cannot be empty");
  });
//UNIT TEST
//this test will check that price validator correctly validates an invalid price
  test('non-numerical price returns null', () async {
    var result = PriceValidator.validate('a3');
    expect(result, "Numeric Values Only");
  });

//UNIT TEST
//this test will check that product name validator correctly validates an empty price
  test('empty product name returns error string', () async {
    var result = ProductNameValidator.validate('');
    expect(result, "Product Name Cannot be Empty");
  });

//UNIT TEST
//this test will check that price validator correctly validates an invalid category
  test('invalid product name returns null', () async {
    var result = ProductNameValidator.validate('nb');
    expect(result, "Please Enter Product Name (3 Characters Min)");
  });
}
