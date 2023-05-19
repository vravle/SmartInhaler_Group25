// import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/post_screen.dart';
import 'package:flutter_app/screens/fetch.dart';
import 'package:flutter_app/screens/home.dart';
// import 'package:flutter_app/dashboard.dart';
// import 'package:flutter_app/screens/fetch.dart';
// import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/read_data.dart';
import 'package:flutter_app/stream.dart';
// import 'package:flutter_app/screens/read_data.dart';
// import 'package:flutter_app/signuppg.dart';
import 'package:get/get.dart';

import 'auth_controller.dart';

class WelcomePage extends StatelessWidget {
  String email;
  WelcomePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: w,
              height: h * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/signup2.png"), fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(
                    height: h * 0.2,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    radius: 60,
                    backgroundImage: AssetImage("img/profile.png"),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: w,
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  Text(
                    email,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            RichText(
                text: TextSpan(
              text: "Dashboard",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => Get.to(() => Streamdata()),

              // children: [
              //       TextSpan(
              //   text: "Create",
              //   // ignore: prefer_const_constructors
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //     ),
              //     recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>Dashboard())
              //    // onPressed: ()=> Get.to(const SignupPage())
              //      )
              //     ]
            )),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                AuthController.instance.logOut();
              },
              child: Container(
                  width: w * 0.4,
                  height: h * 0.07,
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      // ignore: prefer_const_constructors
                      image: DecorationImage(
                          image: AssetImage("img/btn.png"), fit: BoxFit.cover)),
                  child: Center(
                    child: Text("Sign Out",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  )),
            ),
          ],
        ));
  }
}
