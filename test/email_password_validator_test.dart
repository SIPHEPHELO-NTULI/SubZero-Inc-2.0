import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/email_field_validator.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/password_field_validator.dart';
//import 'package:test';

void main() {
  //UNIT TEST
//this test will check that email validator correctly validates an empty email
  test('empty email returns error string', () async {
    var result = EmailFieldValidator.validate('');
    expect(result, "Please Enter Your Email");
  });

//UNIT TEST
//this test will check that email validator correctly validates an invalid email
  test('non-empty email returns error string', () async {
    var result = EmailFieldValidator.validate('email');
    expect(result, "Please enter a valid email");
  });

  //UNIT TEST
//this test will check that email validator correctly validates a valid email
  test('valid email returns null', () async {
    var result = EmailFieldValidator.validate('123@gmail.com');
    expect(result, null);
  });
//UNIT TEST
//this test will check that password validator correctly validates an empty password
  test('empty password returns error string', () async {
    var result = PasswordFieldValidator.validate('');
    expect(result, "Password Required");
  });

//UNIT TEST
//this test will check that password validator correctly validates an invalid password
  test('non-empty password returns error string', () async {
    var result = PasswordFieldValidator.validate('pass');
    expect(result, "Please Enter Valid Password (6 Characters Min)");
  });

//UNIT TEST
//this test will check that email validator correctly validates a valid password
  test('valid email returns null', () async {
    var result = PasswordFieldValidator.validate('123@gmail.com');
    expect(result, null);
  });
}
