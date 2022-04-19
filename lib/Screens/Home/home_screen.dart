import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:greenroots/Screens/Home/components/body.dart';
import 'package:greenroots/components/bottom_nav_bar.dart';
import 'package:greenroots/components/snackBar.dart';
import 'package:greenroots/constants.dart';
import 'package:greenroots/notificationService/local_notification_service.dart';
import 'package:greenroots/services/fcm_notification_device_token.dart';
import 'package:greenroots/services/login_service.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  // final String userEmail;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: BottomNavBar(),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryLightColor,
      iconTheme: IconThemeData(color: kPrimaryColor),
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

LoginService get loginService => GetIt.I<LoginService>();
Widget buildMenuItems(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(15),
    child: Wrap(
      runSpacing: 10,
      children: [
        ListTile(
          leading: const Icon(
            Icons.supervised_user_circle_rounded,
            color: kPrimaryColor,
          ),
          title: const Text(
            "User details",
            style: TextStyle(color: kPrimaryColor),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(
            Icons.grass_rounded,
            color: kPrimaryColor,
          ),
          title: const Text(
            "About Us",
            style: TextStyle(color: kPrimaryColor),
          ),
          onTap: () {},
        ),
        const Divider(
          color: Colors.black54,
        ),
        ListTile(
          leading: const Icon(
            Icons.logout_rounded,
            color: kPrimaryColor,
          ),
          title: const Text(
            "Logout",
            style: TextStyle(color: kPrimaryColor),
          ),
          onTap: () async {
            if (FCMNotificationService.refreshToken == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar.buildSnackBar("An error occurred"));
            } else {
              final result = await loginService
                  .logOutUser(FCMNotificationService.refreshToken!);

              print(FCMNotificationService.refreshToken);
              if (result.data! != true) {
                ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar.buildSnackBar("An error occurred"));
              } else {
                Navigator.pushNamed(context, '/');
              }
            }
          },
        ),
      ],
    ),
  );
}

Widget buildHeader(BuildContext context) {
  return Container(
    width: double.infinity,
    color: kPrimaryLightColor,
    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    child: Column(
      children: [
        CircleAvatar(
          radius: 52,
          backgroundImage: AssetImage("assets/images/plant2.PNG"),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "suman@gmail.com",
          style: TextStyle(fontWeight: FontWeight.w500, color: kPrimaryColor),
        ),
      ],
    ),
  );
}
