// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_app/widgets/card_items.dart';
import 'package:flutter_app/widgets/card_main.dart';
// import 'package:flutter_app/widgets/card_section.dart';
import 'package:flutter_app/widgets/custom_clipper.dart';

import '../utils/const.dart';
//import 'package:smartinhaler/const.dart';
//import 'package:mediapp/widgets/card_items.dart';
//import 'package:mediapp/widgets/card_main.dart';
//import 'package:mediapp/widgets/card_section.dart';
//import 'package:mediapp/widgets/custom_clipper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      // SingleChildScrollView(
      backgroundColor: Constants.backgroundColor,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Theme.of(context).accentColor,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),

          // BODY
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              children: <Widget>[
                // Header - Greetings and Avatar
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Welcome,\nUser",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                    CircleAvatar(
                        radius: 26.0,
                        backgroundImage: AssetImage('img/profile.png'))
                  ],
                ),

                SizedBox(height: 50),

                // Main Cards - Heartbeat and Blood Pressure
                Container(
                  height: 160,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      CardMain(
                        image: AssetImage(
                            'img/pill_FILL0_wght400_GRAD0_opsz48.png'),
                        title: "Daily Intake",
                        value: "2",
                        unit: "-",
                        color: Constants.lightGreen,
                        key: UniqueKey(),
                      ),
                      CardMain(
                        image: AssetImage(
                            'img/medication_FILL0_wght400_GRAD0_opsz48.png'),
                        title: "Medicine \n Value",
                        value: "8",
                        unit: "-",
                        color: Constants.lightYellow,
                        key: UniqueKey(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  height: 160,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      CardMain(
                        image: AssetImage(
                            'img/device_thermostat_FILL0_wght400_GRAD0_opsz48.png'),
                        title: "Temperature",
                        value: "28",
                        unit: "C",
                        color: Constants.lightGreen,
                        key: UniqueKey(),
                      ),
                      CardMain(
                        image: AssetImage(
                            'img/humidity_high_FILL0_wght400_GRAD0_opsz48.png'),
                        title: "Humidity",
                        value: "20",
                        unit: "%",
                        color: Constants.lightYellow,
                        key: UniqueKey(),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 50),
                Container(
                    height: 160,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          CardMain(
                            image: AssetImage(
                                'img/air_FILL0_wght400_GRAD0_opsz48.png'),
                            title: "Air Quality",
                            value: "561",
                            unit: "ppm",
                            color: Constants.lightGreen,
                            key: UniqueKey(),
                          ),
                        ])),
              ],
            ),
          )
        ],
        // ),
      ),
    );
  }
}
