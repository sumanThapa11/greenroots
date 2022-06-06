import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/Screens/ErrorScreen/7_error.dart';
import 'package:greenroots/Screens/Login/login_screen.dart';

import 'package:greenroots/components/rectangular_input_field.dart';
import 'package:greenroots/components/rectangular_password_field.dart';
import 'package:greenroots/components/snackBar.dart';

import 'package:greenroots/constants.dart';
import 'package:greenroots/models/api_response.dart';
import 'package:greenroots/models/login_credentials.dart';
import 'package:greenroots/models/login_insert.dart';
import 'package:greenroots/models/user_device_token_insert.dart';
import 'package:greenroots/services/fcm_notification_device_token.dart';
import 'package:greenroots/services/login_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  String deviceToken = "";
  String accessToken = "";
  String refreshToken = "";

  FCMNotificationService get fcmDeviceToken =>
      GetIt.I<FCMNotificationService>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> getDeviceTokenForNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceToken = token.toString();
    print("deviceToken");
    print(token.toString());
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
                    height: size.height / 2.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/login_plant.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  // SizedBox(
                  //   width: size.width * 0.65,
                  //   child: TextLiquidFill(
                  //     text: "greenroots",
                  //     waveColor: kPrimaryColor,
                  //     boxBackgroundColor: Colors.white,
                  //     textStyle: TextStyle(
                  //       fontSize: 40,
                  //       fontWeight: FontWeight.w800,
                  //     ),
                  //     boxHeight: size.height / 5,
                  //   ),
                  // ),
                  Text(
                    "greenroots",
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w800,
                        color: kPrimaryColor),
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
                    errorText: _emailValidate ? 'email is required' : null,
                  ),
                  RectangularPasswordField(
                    controller: _passwordController,
                    hintText: "Password",
                    onChanged: (value) {},
                    errorText:
                        _passwordValidate ? 'password is required' : null,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: size.width / 2.2),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/forgot_password');
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
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

                          //changed for login error checking
                          if (result.data != null) {
                            accessToken = result.data!.token;
                            refreshToken = result.data!.refreshToken;
                          }

                          getDeviceTokenForNotification();
                          setState(() {
                            showSpinner = false;
                          });
                          if (result.error == true &&
                              result.errorMessage == 'unauthorized') {
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
                          } else if (result.error == true &&
                              result.errorMessage == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                CustomSnackBar.buildSnackBar("Server error!!"));
                          } else {
                            // jwt token
                            final String accessTokenAPI = accessToken;
                            final String refreshTokenAPI = refreshToken;
                            // print("accessToken");
                            // print(accessTokenAPI);
                            await LoginService.storage
                                .write(key: "token", value: accessTokenAPI);
                            await LoginService.storage.write(
                                key: "refreshToken", value: refreshTokenAPI);

                            FCMNotificationService.token =
                                await LoginService.getToken("token");

                            FCMNotificationService.refreshToken =
                                await LoginService.getToken("refreshToken");

                            //fcm device token
                            final token =
                                UserDeviceTokenInsert(token: deviceToken);
                            final result = await fcmDeviceToken
                                .registerUserDeviceToken(token);
                            if (result.error == true) {
                              print(
                                  "error occured after login but before device token");
                            } else {
                              Navigator.pushNamed(context, '/home');
                            }
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
