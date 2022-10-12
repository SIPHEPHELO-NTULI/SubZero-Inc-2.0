import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Reviews/review_validator.dart';
//import 'package:test';

//UNIT TEST
//this test will check that email validator correctly validates an empty email
void main() {
  test('empty email returns error string', () async {
    var result = ReviewFieldValidator.validate('');
    expect(result, "Review Cannot be Empty");
  });

//UNIT TEST
//this test will check that email validator correctly validates an invalid email
  test('non-empty email returns null', () async {
    var result = ReviewFieldValidator.validate('d');
    expect(result, "(3 Characters Min)");
  });
}
