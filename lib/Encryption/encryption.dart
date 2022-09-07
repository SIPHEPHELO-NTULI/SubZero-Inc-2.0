import 'package:encrypt/encrypt.dart';

class Encryption {
  final key = "Give Firebase A Little Key! 2022";

  String getEncryptedEmail(String email) {
    Encrypted encrypted = encryptWithAES(key, email);
    String encryptedBase64 = encrypted.base64;
    return encryptedBase64;
  }

  String getDecryptedEmail(email) {
    String decryptedText = decryptWithAES(key, email);
    return decryptedText;
  }
}

///Accepts encrypted data and decrypt it. Returns plain text
String decryptWithAES(String key, Encrypted encryptedData) {
  final cipherKey = Key.fromUtf8(key);
  final encryptService =
      Encrypter(AES(cipherKey, mode: AESMode.cbc)); //Using AES CBC encryption
  final initVector = IV.fromUtf8(key.substring(0,
      16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.

  return encryptService.decrypt(encryptedData, iv: initVector);
}

///Encrypts the given plainText using the key. Returns encrypted data
Encrypted encryptWithAES(String key, String plainText) {
  final cipherKey = Key.fromUtf8(key);
  final encryptService = Encrypter(AES(cipherKey, mode: AESMode.cbc));
  final initVector = IV.fromUtf8(key.substring(0,
      16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.

  Encrypted encryptedData = encryptService.encrypt(plainText, iv: initVector);
  return encryptedData;
}
