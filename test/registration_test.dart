import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/name_field_validator.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/surname_field_validator.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/username_field_validator.dart';

void main() {
//UNIT TEST
//this test will check that name field validator correctly validates an empty name
  test('empty name returns error string', () async {
    var result = NameFieldValidator.validate('');
    expect(result, "Name Cannot be Empty");
  });

//UNIT TEST
//this test will check that name field validator correctly validates an invalid name
  test('invalid name returns null', () async {
    var result = NameFieldValidator.validate('ab');
    expect(result, "Please Enter Valid Name (3 Characters Min)");
  });

//UNIT TEST
//this test will check that surname field validator correctly validates an empty surname
  test('empty surname returns error string', () async {
    var result = SurnameFieldValidator.validate('');
    expect(result, "Surname Cannot be Empty");
  });

//UNIT TEST
//this test will check that surname field validator correctly validates an invalid surname
  test('invalid surname returns null', () async {
    var result = SurnameFieldValidator.validate('ab');
    expect(result, "Please Enter Valid Surname (3 Characters Min)");
  });

//UNIT TEST
//this test will check that username field validator correctly validates an empty username
  test('empty username returns error string', () async {
    var result = UserNameFieldValidator.validate('');
    expect(result, "Username Cannot be Empty");
  });

//UNIT TEST
//this test will check that username field validator correctly validates an invalid username
  test('invalid username returns null', () async {
    var result = UserNameFieldValidator.validate('ab');
    expect(result, "Please Enter Valid Username (3 Characters Min)");
  });
}
