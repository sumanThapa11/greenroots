import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/components/rectangular_input_field.dart';
import 'package:greenroots/components/rectangular_password_field.dart';
import 'package:greenroots/components/rounded_button.dart';
import 'package:greenroots/components/snackBar.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/models/reset_password.dart';
import 'package:greenroots/services/login_service.dart';
import 'package:pinput/pinput.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.userData}) : super(key: key);
  final Map<String, dynamic> userData;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  LoginService get loginService => GetIt.I<LoginService>();
  String otp = "";
  bool _showSpinner = false;
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _showSpinner
        ? kCircularProgressIndicator
        : SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 12,
                    ),
                    Text(
                      "Enter verification code",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    Pinput(
                      onCompleted: (pin) {
                        otp = pin;
                      },
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    RectangularPasswordField(
                      controller: passwordController,
                      hintText: "new password",
                      onChanged: (value) {},
                    ),
                    RectangularPasswordField(
                      controller: password2Controller,
                      hintText: "confirm password",
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    RoundedButton(
                      text: "Continue",
                      press: () async {
                        final result;
                        if (otp != widget.userData['otp']) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.buildSnackBar(
                                  "Otp did not matched"));
                        } else if (passwordController.text.isEmpty ||
                            password2Controller.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.buildSnackBar(
                                  "Please fill all the fields"));
                        } else if (passwordController.text !=
                            password2Controller.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.buildSnackBar(
                                  "Passwords did not matched"));
                        } else {
                          final userDetails = ResetPassword(
                            email: widget.userData["email"],
                            password: passwordController.text,
                            password2: password2Controller.text,
                          );
                          setState(() {
                            _showSpinner = true;
                          });
                          result =
                              await loginService.resetPassword(userDetails);
                          setState(() {
                            _showSpinner = false;
                          });
                          if (result.error != true) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Password reset successful"),
                              backgroundColor: kSecondaryColor,
                            ));
                            Navigator.of(context).pushNamed('/');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.buildSnackBar(
                                    "An error occurred"));
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
