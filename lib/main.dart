import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/Screens/Home/home_screen.dart';
import 'package:greenroots/Screens/Login/login_screen.dart';
import 'package:greenroots/Screens/Signup/signup_screen.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/services/login_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => LoginService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'greenroots',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Poppins'),
      initialRoute: '/home',
      routes: {
        '/': (context) => LoginScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
