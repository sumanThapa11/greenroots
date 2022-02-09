import 'package:flutter/material.dart';
import 'package:greenroots/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff76B536),
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
