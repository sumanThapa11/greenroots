import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenroots/components/text_field_container.dart';
import 'package:greenroots/constants.dart';

class RectangularInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? errorText;
  final TextInputType? keyBoardType;

  RectangularInputField(
      {Key? key,
      required this.hintText,
      this.icon = Icons.person,
      this.controller,
      required this.onChanged,
      this.errorText,
      this.keyBoardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        controller: controller,

        // enableSuggestions: true,
        keyboardType: keyBoardType == null ? TextInputType.text : keyBoardType,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
          errorText: errorText,
          errorStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
