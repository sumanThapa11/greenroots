import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:greenroots/Screens/Home/components/body.dart';
import 'package:greenroots/components/bottom_nav_bar.dart';
import 'package:greenroots/constants.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryLightColor,
      leading: IconButton(
        icon: Icon(
          LineIcons.bars,
          color: kPrimaryColor,
          size: 24,
        ),
        onPressed: () {},
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
    );
  }
}
