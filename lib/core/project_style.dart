import 'package:flutter/material.dart';

class CustomColors {
  final Color white = const Color(0xFFFFFFFF);
  final Color black = const Color(0xFF000000);
  final Color primary = const Color(0xFF007BFF);
  final Color secondary = const Color(0xFF6C757D);
  final Color success = const Color(0xFF28A745);
  final Color danger = const Color(0xFFDC3545);
  final Color warning = const Color(0xFFFFC107);
  final Color info = const Color(0xFF17A2B8);
  final Color light = const Color(0xFFF8F9FA);
  final Color dark = const Color(0xFF343A40);
}

class CustomPaddings {
  final p10 = const EdgeInsets.all(10);
  final p15 = const EdgeInsets.all(15);
  final p20 = const EdgeInsets.all(20);
  final pv10 = const EdgeInsets.symmetric(vertical: 10);
  final pv15 = const EdgeInsets.symmetric(vertical: 15);
  final pv20 = const EdgeInsets.symmetric(vertical: 20);
  final pv30 = const EdgeInsets.symmetric(vertical: 30);
  final ph10 = const EdgeInsets.symmetric(horizontal: 10);
  final ph15 = const EdgeInsets.symmetric(horizontal: 15);
  final ph20 = const EdgeInsets.symmetric(horizontal: 20);
  final ph30 = const EdgeInsets.symmetric(horizontal: 30);
}

class CustomTextStyle {
  final TextStyle f26 = const TextStyle(fontSize: 26);
  final TextStyle f26b = const TextStyle(fontSize: 26, fontWeight: FontWeight.bold);

  final TextStyle f24 = const TextStyle(fontSize: 24);
  final TextStyle f24b = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  final TextStyle f22 = const TextStyle(fontSize: 22);
  final TextStyle f22b = const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);

  final TextStyle f20 = const TextStyle(fontSize: 20);
  final TextStyle f20b = const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

  final TextStyle f16 = const TextStyle(fontSize: 16);
  final TextStyle f16b = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  final TextStyle f15 = const TextStyle(fontSize: 15);
  final TextStyle f15b = const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  final TextStyle f13 = const TextStyle(fontSize: 13);
  final TextStyle f13b = const TextStyle(fontSize: 13, fontWeight: FontWeight.bold);

  final TextStyle f11 = const TextStyle(fontSize: 11);
  final TextStyle f11b = const TextStyle(fontSize: 11, fontWeight: FontWeight.bold);
}

class CustomButton {
  final action = ElevatedButton.styleFrom(
    primary: CustomColors().primary,
    onPrimary: CustomColors().white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(width: 0, style: BorderStyle.none),
    ),
  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));

  final danger = ElevatedButton.styleFrom(
    primary: CustomColors().danger,
    onPrimary: CustomColors().white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(width: 0, style: BorderStyle.none),
    ),
  ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0));
}
