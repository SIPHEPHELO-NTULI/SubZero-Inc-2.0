import 'package:flutter_test/flutter_test.dart';
import 'package:give_a_little_sdp/Encryption/encryption.dart';

//UNIT TEST
//this test will check that the cart total displays the correct total
void main() {
  test('test Encryption Function', () {
    final enc = Encryption();
    expect(enc.getEncryptedEmail("123@gmail.com"), "lNKGGc0sbIWQk8t49SFC1A==");
  });
}
