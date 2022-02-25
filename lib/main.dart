import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/route_generator.dart';
import 'package:greenroots/services/cart_service.dart';
import 'package:greenroots/services/login_service.dart';
import 'package:greenroots/services/plants_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => LoginService());
  GetIt.I.registerLazySingleton(() => PlantsService());
  GetIt.I.registerLazySingleton(() => CartService());
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
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

// routes: {
//   '/': (context) => LoginScreen(),
//   '/signUp': (context) => SignUpScreen(),
//   '/home': (context) => HomeScreen(),
//   '/plantDetails': (context) => PlantDetailsScreen(),
// },
