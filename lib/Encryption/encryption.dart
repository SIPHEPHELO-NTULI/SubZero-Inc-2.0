import 'package:encrypt/encrypt.dart';

//This class is used to encrypt and decrypt a users email address
class Encryption {
  final key = "Give Firebase A Little Key! 2022";
//function that will return an encrypted email
  String getEncryptedEmail(String email) {
    Encrypted encrypted = encryptWithAES(key, email);
    String encryptedBase64 = encrypted.base64;
    return encryptedBase64;
  }
}

///Encrypts the given plainText using the key. Returns encrypted data
Encrypted encryptWithAES(String key, String plainText) {
  final cipherKey = Key.fromUtf8(key);
  final encryptService = Encrypter(AES(cipherKey, mode: AESMode.cbc));
  final initVector =
      IV.fromUtf8(key.substring(0, 16)); //Here the IV is generated from key.

  Encrypted encryptedData = encryptService.encrypt(plainText, iv: initVector);
  return encryptedData;
}
