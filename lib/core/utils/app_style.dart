import 'package:flutter/material.dart';

class AppStyle {
  static ThemeData theme = ThemeData(
      primaryColor: Colors.blueGrey,
      hintColor: Colors.grey,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      // fontFamily:,
      textTheme: const TextTheme(
          bodyMedium: TextStyle(
        fontSize: 20,
        height: 1.2,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      )));
}
