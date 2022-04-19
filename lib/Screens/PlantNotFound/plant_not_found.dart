import 'package:flutter/material.dart';

class PlantNotFoundScreen extends StatelessWidget {
  const PlantNotFoundScreen({Key? key, required this.plantName})
      : super(key: key);
  final String plantName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          width: size.width / 1.3,
          height: size.height / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Colors.white,
          ),
          margin: EdgeInsets.all(25),
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "           ",
                  ),
                  Text(
                    "plant details",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Text(
                "Name - " + plantName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: size.height / 35,
              ),
              Text(
                "*the plant is currently unavailable.",
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
      ),
    );
  }
}
