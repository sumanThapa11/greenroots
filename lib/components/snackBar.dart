import 'package:flutter/material.dart';

class CustomSnackBar {
  static SnackBar buildSnackBar(String text) {
    return SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Colors.red,
    );
  }
}
