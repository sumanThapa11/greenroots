import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/components/rounded_button.dart';
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

  @override
  Widget build(BuildContext context) {
    String otp = "";
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height / 25,
              ),
              Text(
                "OTP Verification",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
              ),
              Text(
                "We sent your code to test@gmail.com",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: size.height / 16,
              ),
              Pinput(
                onCompleted: (pin) {
                  otp = pin;
                },
              ),
              SizedBox(
                height: size.height / 5,
              ),
              RoundedButton(
                text: "Continue",
                press: () async {
                  if (otp == widget.userData['otp']) {
                    print("ok cha ta");

                    final result = await loginService
                        .registerUser(widget.userData['user']);

                    // setState(() {
                    //   showSpinner = false;
                    // });

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
                      if (result.data!) {
                        Navigator.of(context).pop();
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "OTP did not matched",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        duration: Duration(seconds: 4),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
