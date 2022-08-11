import 'package:encrypt/encrypt.dart';

class Crypt {
  final key = Key.fromUtf8('SNnXG5hC8sNl5AlbkF6TWG5KTlLpe2IN');
  final iv = IV.fromUtf8('WGWw2kCRe3N7NM8E');

  String encrypt(String text) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  String decrypt(String text) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(text), iv: iv);
    return decrypted;
  }
}
