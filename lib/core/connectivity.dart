import 'dart:io';

class Connectivity {
  Future<bool> check() async {
    bool connect1 = false;
    bool connect2 = false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connect1 = true;
      }
    } on SocketException catch (_) {
      connect1 = false;
    }

    try {
      final result = await InternetAddress.lookup('turkiye.gov.tr');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connect2 = true;
      }
    } on SocketException catch (_) {
      connect2 = false;
    }

    if (connect1 || connect2) {
      return true;
    } else {
      return false;
    }
  }
}
