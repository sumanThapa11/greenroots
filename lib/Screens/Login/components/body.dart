import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:greenroots/components/rectangular_input_field.dart';
import 'package:greenroots/components/rectangular_password_field.dart';

import 'package:greenroots/constants.dart';
import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/login_credentials.dart';
import 'package:greenroots/models/login_insert.dart';
import 'package:greenroots/services/login_service.dart';

import 'background.dart';
import 'package:greenroots/components/rounded_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool showSpinner = false;

  bool _emailValidate = false;
  bool _passwordValidate = false;

  LoginService get loginService => GetIt.I<LoginService>();
  APIResponse<LoginCredentials>? _apiResponse;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //This size provides us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: showSpinner
            ? CircularProgressIndicator(
                backgroundColor: kPrimaryLightColor,
                color: kPrimaryColor,
              )
            : Column(
                children: [
                  Container(
                    height: 225,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/login_plant.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: TextLiquidFill(
                      text: "greenroots",
                      waveColor: kPrimaryColor,
                      boxBackgroundColor: Colors.white,
                      textStyle: TextStyle(
                        fontSize: 43,
                        fontWeight: FontWeight.w800,
                      ),
                      boxHeight: 81,
                    ),
                  ),
                  Text(
                    "Login to your account",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RectangularInputField(
                    controller: _emailController,
                    hintText: "Your Email",
                    onChanged: (value) {},
                    errorText: _emailValidate ? 'Empty field' : null,
                  ),
                  RectangularPasswordField(
                    controller: _passwordController,
                    hintText: "Password",
                    onChanged: (value) {},
                    errorText: _passwordValidate ? 'Empty field' : null,
                  ),
                  SizedBox(
                    height: size.height * 0.10,
                  ),
                  RoundedButton(
                      text: "Login",
                      press: () async {
                        if (_emailController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          Future.delayed(Duration.zero, () {
                            setState(() {
                              _emailController.text.isEmpty
                                  ? _emailValidate = true
                                  : _emailValidate = false;
                              _passwordController.text.isEmpty
                                  ? _passwordValidate = true
                                  : _passwordValidate = false;
                            });
                          });
                        } else {
                          setState(() {
                            showSpinner = true;
                          });
                          //login api
                          final loginData = LoginInsert(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          final result =
                              await loginService.loginUser(loginData);
                          setState(() {
                            showSpinner = false;
                          });
                          if (result.error == true) {
                            // print(result.errorMessage);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Invalid login credentials",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                duration: Duration(seconds: 4),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else {
                            Navigator.pushNamed(context, '/home');
                          }
                        }
                      }),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ? ",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signUp');
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
