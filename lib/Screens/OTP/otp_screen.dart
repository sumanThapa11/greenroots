import 'package:flutter/material.dart';
import 'package:greenroots/components/rounded_back_button.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/Screens/OTP/components/body.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key, required this.userData}) : super(key: key);
  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        leading: RoundedBackButton(
          color: kPrimaryLightColor,
        ),
        title: Center(
          child: Text(
            "OTP Verification",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ),
      body: Body(
        userData: userData,
      ),
    );
  }
}
