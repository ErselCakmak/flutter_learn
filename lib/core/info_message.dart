import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core/project_style.dart';

enum ToastType { success, error }

abstract class ToastMessage {
  static void showToast(String msg, String type) {
    Color bgColor = CustomColors().danger;
    Color textColor = CustomColors().white;
    double fontSize = 16.0;

    if (type == ToastType.success.name) {
      bgColor = CustomColors().success;
      textColor = CustomColors().black;
    }

    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: fontSize);
  }
}
