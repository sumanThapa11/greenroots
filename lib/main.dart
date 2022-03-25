import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/route_generator.dart';
import 'package:greenroots/services/cart_service.dart';
import 'package:greenroots/services/login_service.dart';
import 'package:greenroots/services/plant_scanner_service.dart';
import 'package:greenroots/services/plants_service.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

const String testPublicKey = 'test_public_key_097468858cbc40f0a9e2f3c9ece17e95';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => LoginService());
  GetIt.I.registerLazySingleton(() => PlantsService());
  GetIt.I.registerLazySingleton(() => CartService());
  GetIt.I.registerLazySingleton(() => PlantScannerService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: testPublicKey,
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            title: 'greenroots',
            theme: ThemeData(
                primaryColor: kPrimaryColor,
                scaffoldBackgroundColor: Colors.white,
                fontFamily: 'Poppins'),
            initialRoute: '/home',
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'greenroots',
    //   theme: ThemeData(
    //       primaryColor: kPrimaryColor,
    //       scaffoldBackgroundColor: Colors.white,
    //       fontFamily: 'Poppins'),
    //   initialRoute: '/home',
    //   onGenerateRoute: RouteGenerator.generateRoute,
    // );
  }
}

// routes: {
//   '/': (context) => LoginScreen(),
//   '/signUp': (context) => SignUpScreen(),
//   '/home': (context) => HomeScreen(),
//   '/plantDetails': (context) => PlantDetailsScreen(),
// },
