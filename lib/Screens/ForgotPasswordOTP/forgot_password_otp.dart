import 'package:flutter/material.dart';
import 'package:greenroots/components/rounded_back_button.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/Screens/ForgotPasswordOTP/components/body.dart';

class ForgotPasswordOTPScreen extends StatelessWidget {
  const ForgotPasswordOTPScreen({Key? key, required this.userData})
      : super(key: key);
  final Map<String, dynamic> userData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        leading: RoundedBackButton(
          color: kPrimaryLightColor,
        ),
        title: Text(
          "Verify OTP",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: Body(
        userData: userData,
      ),
    );
  }
}
