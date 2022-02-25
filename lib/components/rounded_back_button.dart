import 'package:flutter/material.dart';
import 'package:greenroots/constants.dart';

class RoundedBackButton extends StatelessWidget {
  const RoundedBackButton({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: 18,
        color: kPrimaryColor,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimaryLightColor),
        shape: MaterialStateProperty.all(
          CircleBorder(),
        ),
        shadowColor: MaterialStateProperty.all(Colors.white),
        side: MaterialStateProperty.all(
          BorderSide(color: color),
        ),
        minimumSize: MaterialStateProperty.all(
          Size(40, 40),
        ),
      ),
    );
  }
}
