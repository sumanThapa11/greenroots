import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/Screens/Signup/components/background.dart';
import 'package:greenroots/components/rectangular_input_field.dart';
import 'package:greenroots/components/rectangular_password_field.dart';
import 'package:greenroots/components/rounded_button.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/models/register_insert.dart';
import 'package:greenroots/services/login_service.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  LoginService get loginService => GetIt.I<LoginService>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _nameValidate = false;
  bool _emailValidate = false;
  bool _addressValidate = false;
  bool _phoneValidate = false;
  bool _passwordValidate = false;
  bool _confirmPasswordValidate = false;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: showSpinner
            ? CircularProgressIndicator(
                backgroundColor: kPrimaryLightColor,
                color: kPrimaryColor,
              )
            : Column(
                children: [
                  SafeArea(
                    child: Container(
                      margin: EdgeInsets.only(top: 15, left: 15),
                      alignment: Alignment.topLeft,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: kPrimaryColor,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryLightColor),
                          shape: MaterialStateProperty.all(
                            CircleBorder(),
                          ),
                          shadowColor: MaterialStateProperty.all(Colors.white),
                          side: MaterialStateProperty.all(
                            BorderSide(color: Colors.white),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            Size(40, 40),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                  Text(
                    "Create your new account",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  RectangularInputField(
                    controller: _nameController,
                    hintText: "Full Name",
                    onChanged: (value) {},
                    errorText: _nameValidate ? 'Empty field' : null,
                  ),
                  RectangularInputField(
                    controller: _emailController,
                    hintText: "Email",
                    icon: Icons.email_rounded,
                    onChanged: (value) {},
                    errorText: _emailValidate ? 'Empty field' : null,
                  ),
                  RectangularInputField(
                    controller: _addressController,
                    hintText: "Address",
                    icon: Icons.house_rounded,
                    onChanged: (value) {},
                    errorText: _addressValidate ? 'Empty field' : null,
                  ),
                  RectangularInputField(
                    controller: _phoneController,
                    hintText: "Phone",
                    icon: Icons.phone,
                    onChanged: (value) {},
                    errorText: _phoneValidate ? 'Empty field' : null,
                  ),
                  RectangularPasswordField(
                    controller: _passwordController,
                    hintText: "Password",
                    onChanged: (value) {},
                    errorText: _passwordValidate ? 'Empty field' : null,
                  ),
                  RectangularPasswordField(
                    controller: _confirmPasswordController,
                    hintText: "Confirm Password",
                    onChanged: (value) {},
                    errorText: _confirmPasswordValidate ? 'Empty field' : null,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  RoundedButton(
                    text: "Sign Up",
                    press: () async {
                      final result;
                      if (_nameController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _addressController.text.isEmpty ||
                          _phoneController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _confirmPasswordController.text.isEmpty) {
                        Future.delayed(Duration.zero, () {
                          setState(() {
                            _nameController.text.isEmpty
                                ? _nameValidate = true
                                : _nameValidate = false;
                            _emailController.text.isEmpty
                                ? _emailValidate = true
                                : _emailValidate = false;
                            _addressController.text.isEmpty
                                ? _addressValidate = true
                                : _addressValidate = false;
                            _phoneController.text.isEmpty
                                ? _phoneValidate = true
                                : _phoneValidate = false;
                            _passwordController.text.isEmpty
                                ? _passwordValidate = true
                                : _passwordValidate = false;
                            _confirmPasswordController.text.isEmpty
                                ? _confirmPasswordValidate = true
                                : _confirmPasswordValidate = false;
                          });
                        });
                      } else {
                        setState(() {
                          showSpinner = true;
                        });
                        String firstName;
                        String lastName;

                        // providing blank text if th users supply first name only
                        if (_nameController.text.split(" ").length > 1) {
                          firstName = _nameController.text.split(" ")[0];
                          lastName = _nameController.text.split(" ")[1];
                        } else {
                          firstName = _nameController.text.split(" ")[0];
                          lastName = "------";
                        }

                        final user = RegisterInsert(
                          email: _emailController.text,
                          firstName: firstName,
                          lastName: lastName,
                          address: _addressController.text,
                          phone: _phoneController.text,
                          password: _passwordController.text,
                          confirmPassword: _confirmPasswordController.text,
                        );

                        result = await loginService.registerUser(user);

                        setState(() {
                          showSpinner = false;
                        });

                        final title = 'Submitted';
                        final text = result.error
                            ? (result.errorMessage ?? 'An error occured')
                            : 'User is created';

                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(title),
                            content: Text(text),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              )
                            ],
                          ),
                        ).then((data) {
                          if (result.data) {
                            Navigator.of(context).pop();
                          }
                        });
                      }
                    },
                  )
                ],
              ),
      ),
    );
  }
}
