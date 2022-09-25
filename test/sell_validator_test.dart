import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/categoryvalidator.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/pricevalidator.dart';
import 'package:give_a_little_sdp/Screens/Sell/Validation/productNameValidator.dart';

void main() {
  test('empty price returns error string', () async {
    var result = PriceValidator.validate('');
    expect(result, "Price cannot be empty");
  });

  test('non-numerical price returns null', () async {
    var result = PriceValidator.validate('a3');
    expect(result, "Numeric Values Only");
  });

  test('empty category returns error string', () async {
    var result = CategoryValidator.validate('');
    expect(result, "Category Cannot be Empty");
  });

  test('invalid category returns null', () async {
    var result = CategoryValidator.validate('ab');
    expect(result, "Please Enter A Category (3 Characters Min)");
  });

  test('empty product name returns error string', () async {
    var result = ProductNameValidator.validate('');
    expect(result, "Product Name Cannot be Empty");
  });

  test('invalid product name returns null', () async {
    var result = ProductNameValidator.validate('nb');
    expect(result, "Please Enter Product Name (3 Characters Min)");
  });
}
