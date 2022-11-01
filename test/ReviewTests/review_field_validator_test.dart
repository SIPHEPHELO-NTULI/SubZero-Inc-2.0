import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Reviews/review_validator.dart';
//import 'package:test';

void main() {
  //UNIT TEST
//this test will check that review field validator correctly validates an empty review
  test('empty review returns error string', () async {
    var result = ReviewFieldValidator.validate('');
    expect(result, "Review Cannot be Empty");
  });

//UNIT TEST
//this test will check that review field validator correctly validates an invalid review
  test('non-empty review returns error string', () async {
    var result = ReviewFieldValidator.validate('d');
    expect(result, "(3 Characters Min)");
  });

  //UNIT TEST
//this test will check that email validator correctly validates a valid review
  test('valid review returns null', () async {
    var result = ReviewFieldValidator.validate('Great Buy');
    expect(result, null);
  });
}
