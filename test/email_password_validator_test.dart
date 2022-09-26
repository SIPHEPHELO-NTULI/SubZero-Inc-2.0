import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/emailFieldValidator.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/passwordFieldValidator.dart';
//import 'package:test';

//UNIT TEST
//this test will check that email validator correctly validates an empty email
void main() {
  test('empty email returns error string', () async {
    var result = EmailFieldValidator.validate('');
    expect(result, "Please Enter Your Email");
  });

//UNIT TEST
//this test will check that email validator correctly validates an invalid email
  test('non-empty email returns null', () async {
    var result = EmailFieldValidator.validate('email');
    expect(result, "Please enter a valid email");
  });

//UNIT TEST
//this test will check that password validator correctly validates an empty password
  test('empty password returns error string', () async {
    var result = PasswordFieldValidator.validate('');
    expect(result, "Password Required");
  });

//UNIT TEST
//this test will check that password validator correctly validates an invalid password
  test('non-empty password returns null', () async {
    var result = PasswordFieldValidator.validate('pass');
    expect(result, "Please Enter Valid Password (6 Characters Min)");
  });
}
