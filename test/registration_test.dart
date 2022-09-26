import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/nameFieldValidator.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/surnameFieldValidator.dart';
import 'package:give_a_little_sdp/Screens/Login/Validation/userNameFieldValidator.dart';

void main() {
  test('empty name returns error string', () async {
    var result = NameFieldValidator.validate('');
    expect(result, "Name Cannot be Empty");
  });

  test('invalid name returns null', () async {
    var result = NameFieldValidator.validate('ab');
    expect(result, "Please Enter Valid Name (3 Characters Min)");
  });

  test('empty surname returns error string', () async {
    var result = SurnameFieldValidator.validate('');
    expect(result, "Surname Cannot be Empty");
  });

  test('invalid surname returns null', () async {
    var result = SurnameFieldValidator.validate('ab');
    expect(result, "Please Enter Valid Surname (3 Characters Min)");
  });

  test('empty username returns error string', () async {
    var result = UserNameFieldValidator.validate('');
    expect(result, "Username Cannot be Empty");
  });

  test('invalid username returns null', () async {
    var result = UserNameFieldValidator.validate('ab');
    expect(result, "Please Enter Valid Username (3 Characters Min)");
  });
}
