import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/price_validator.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/product_name_validator.dart';

//UNIT TEST
//this test will check that price validator correctly validates an empty price
void main() {
  test('empty price returns error string', () async {
    var result = PriceValidator.validate('');
    expect(result, "Price cannot be empty");
  });
//UNIT TEST
//this test will check that price validator correctly validates an invalid price
  test('non-numerical price returns error string', () async {
    var result = PriceValidator.validate('a3');
    expect(result, "Numeric Values Only");
  });

  //UNIT TEST
//this test will check that price validator correctly validates a valid price
  test('valid price returns null', () async {
    var result = PriceValidator.validate('100');
    expect(result, null);
  });

//UNIT TEST
//this test will check that product name validator correctly validates an empty product name
  test('empty product name returns error string', () async {
    var result = ProductNameValidator.validate('');
    expect(result, "Product Name Cannot be Empty");
  });

//UNIT TEST
//this test will check that price validator correctly validates an invalid product name
  test('invalid product name returns null', () async {
    var result = ProductNameValidator.validate('nb');
    expect(result, "Please Enter Product Name (3 Characters Min)");
  });

  //UNIT TEST
//this test will check that price validator correctly validates a valid product name
  test('valid product name returns null', () async {
    var result = ProductNameValidator.validate('Shoes');
    expect(result, null);
  });
}
