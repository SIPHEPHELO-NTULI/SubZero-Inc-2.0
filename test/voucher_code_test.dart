import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Redeem/voucher_code_validator.dart';

//UNIT TEST
//this test will check that voucher code validator correctly validates an empty voucher code
void main() {
  test('empty voucher code returns error string', () async {
    var result = VoucherCodeValidator.validate('');
    expect(result, "Voucher Code Cannot be Empty");
  });
//UNIT TEST
//this test will check that voucher code validator correctly validates a short voucher code
  test('voucher code length less than 12 returns null', () async {
    var result = VoucherCodeValidator.validate('12212');
    expect(result, "Please Enter Valid Voucher Code (12 Character Code Only)");
  });

//this test will check that voucher code validator correctly validates a long voucher code
  test('voucher code length less than 12 returns null', () async {
    var result = VoucherCodeValidator.validate('12212123123123');
    expect(result, "Please Enter Valid Voucher Code (12 Character Code Only)");
  });
}
