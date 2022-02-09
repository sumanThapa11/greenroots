import 'package:flutter/material.dart';
import 'package:greenroots/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: OutlinedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 40,
              ),
            ),
            backgroundColor: MaterialStateProperty.all(color),
            foregroundColor: MaterialStateProperty.all<Color>(textColor),
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
