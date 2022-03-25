import 'package:flutter/material.dart';
import 'package:greenroots/components/rounded_back_button.dart';
import 'package:greenroots/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:greenroots/Screens/MyPlants/components/body.dart';

class MyPlantsScreen extends StatelessWidget {
  const MyPlantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        leading: RoundedBackButton(
          color: kPrimaryLightColor,
        ),
        title: Center(
          child: Text(
            "My Plants",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/cart');
            },
            icon: Icon(
              LineIcons.shoppingCart,
              color: kPrimaryColor,
              size: 32,
            ),
          ),
        ],
      ),
      body: Body(),
    );
    ;
  }
}
