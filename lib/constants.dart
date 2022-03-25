import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF184A2C);
const kPrimaryLightColor = Color(0xFFEBFDF2);
const kSecondaryColor = Color(0xFF76B536);

const double kDefaultPadding = 20.0;

const Widget kCircularProgressIndicator = Center(
  child: CircularProgressIndicator(
    backgroundColor: kPrimaryColor,
    color: kPrimaryLightColor,
  ),
);

const SnackBar kErrorSnackBar = SnackBar(
  content: Text(
    "An error occurred",
    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  ),
  duration: Duration(seconds: 4),
  backgroundColor: Colors.red,
);

// const String kImageUrl = "http://192.168.1.69:8000";
const String kImageUrl = "http://10.0.2.2:8000";
