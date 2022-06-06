import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/components/rectangular_input_field.dart';
import 'package:greenroots/components/rounded_button.dart';
import 'package:greenroots/components/snackBar.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/services/login_service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  LoginService get loginService => GetIt.I<LoginService>();
  final emailController = TextEditingController();
  bool _showSpinner = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _showSpinner
        ? kCircularProgressIndicator
        : SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Text(
                      "Forgot password",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Please enter your email and we will send you an OTP to verify your account.",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    RectangularInputField(
                      keyBoardType: TextInputType.emailAddress,
                      controller: emailController,
                      hintText: "email",
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    RoundedButton(
                        text: "Continue",
                        press: () async {
                          if (emailController.text.isNotEmpty) {
                            final result;
                            final emailResult;
                            print(emailController.text);
                            setState(() {
                              _showSpinner = true;
                            });
                            result = await loginService
                                .searchUser(emailController.text);
                            if (result.error != true) {
                              emailResult = await loginService
                                  .sendEmailToken(emailController.text);
                              setState(() {
                                _showSpinner = false;
                              });
                              if (!emailResult.error) {
                                String otp = emailResult.data;
                                Map<String, dynamic> userData = {
                                  "email": emailController.text,
                                  "otp": otp,
                                };
                                Navigator.of(context).pushNamed(
                                    '/forgot_password_otp',
                                    arguments: userData);
                              }
                            } else {
                              setState(() {
                                _showSpinner = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.buildSnackBar(
                                    "The user does not exists."),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar.buildSnackBar(
                                  "Please enter email."),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
  }
}
