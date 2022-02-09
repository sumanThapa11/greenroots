import 'package:flutter/material.dart';
import 'package:greenroots/components/text_field_container.dart';
import 'package:greenroots/constants.dart';

class RectangularPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;
  final String? errorText;
  final TextEditingController? controller;
  RectangularPasswordField({
    Key? key,
    required this.onChanged,
    required this.hintText,
    this.errorText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          // suffixIcon: Icon(
          //   Icons.visibility,
          //   color: kPrimaryColor,
          // ),

          border: InputBorder.none,
          errorText: errorText,
          errorStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
