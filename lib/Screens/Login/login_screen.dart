import 'package:flutter/material.dart';
import 'package:greenroots/Screens/Login/components/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Body(),
      ),
    );
  }
}
