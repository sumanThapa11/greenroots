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
