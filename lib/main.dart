import 'package:flutter/material.dart';
//import 'package:smartinhaler/auth_controller.dart';
//import 'package:smartinhaler/dashboard.dart';
//import 'package:smartinhaler/loginpg.dart';
//import 'package:smartinhaler/signuppg.dart';
//import 'package:smartinhaler/splash_screen.dart';
//import 'package:smartinhaler/welcome.dart';
import 'package:get/get.dart';
// import 'package:flutter/gestures.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth_controller.dart';
import 'loginpg.dart';
//import "const.dart";
// import '../utils/const.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage());
  }
}
