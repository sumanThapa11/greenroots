import 'package:flutter/material.dart';
import 'package:greenroots/Screens/Cart/add_to_cart_screen.dart';
import 'package:greenroots/Screens/Cart/cart_screen.dart';
import 'package:greenroots/Screens/CategorysPlants/categorys_plants_screen.dart';
import 'package:greenroots/Screens/Checkout/checkout_screen.dart';

import 'package:greenroots/Screens/Home/home_screen.dart';
import 'package:greenroots/Screens/Login/login_screen.dart';
import 'package:greenroots/Screens/PlantDetails/plant_details_screen.dart';
import 'package:greenroots/Screens/Signup/signup_screen.dart';
import 'package:greenroots/main.dart';
import 'package:greenroots/models/plant_list.dart';
import 'package:greenroots/models/users_cart_items.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/plantDetails':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => PlantDetailsScreen(plantId: args),
          );
        }
        return _errorRoute();
      case '/categoryPlants':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => CategoryPlants(plantId: args),
          );
        }
        return _errorRoute();
      case '/addToCart':
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            builder: (_) => AddToCartScreen(plant: args),
          );
        }
        return _errorRoute();
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      case '/checkout':
        if (args is UsersCartItem) {
          return MaterialPageRoute(
            builder: (_) => CheckoutScreen(
              usersCartItem: args,
            ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
