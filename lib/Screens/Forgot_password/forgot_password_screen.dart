import 'package:flutter/material.dart';
import 'package:greenroots/components/rounded_back_button.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/Screens/Forgot_password/components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        leading: RoundedBackButton(
          color: kPrimaryLightColor,
        ),
        title: Text(
          "Forgot Password",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: Body(),
    );
  }
}
