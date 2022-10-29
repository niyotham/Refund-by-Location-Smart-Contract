import 'package:encrypt/encrypt.dart';
import 'package:flutterdapp/main.dart' as pass;

class EncryptionDecryption {
  static final Encrypter encrypter =
      Encrypter(AES(Key.fromUtf8(pass.password)));
  static final iv = IV.fromLength(16);
  static String encryptAES(String text) {
    return encrypter.encrypt(text, iv: iv).base64;
  }

  static String decryptAES(String encryptedText) {
    final encrypted = Encrypted.fromBase64(encryptedText);
    return encrypter.decrypt(encrypted, iv: iv);
  }
}
