import 'package:flutter/material.dart';
import 'package:flutter_app/auth_controller.dart';
//import 'package:flutter_login_project/auth_controller.dart';

class SignupPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //const SignupPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List images = ["g.png", "f.png", "t.png"];
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
                    height: h * 0.05,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    radius: 60,
                    backgroundImage: AssetImage("img/profile.png"),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    //width: w*0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "Your email id",
                            prefixIcon: Icon(Icons.email,
                                color: Color.fromARGB(255, 40, 133, 254)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)))),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Your password",
                            prefixIcon: Icon(Icons.password_outlined,
                                color: Color.fromARGB(255, 40, 133, 254)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 1.0,
                                )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)))),
                  ),
                  SizedBox(height: 20),
                  // Row(
                  //   children: [
                  //     Expanded(child: Container(),),
                  //     Text(
                  //   "Sign in to your account.",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     color: Colors.grey[500]
                  //   )
                  // ),
                  //   ],
                  // )
                ],
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                AuthController.instance.register(emailController.text.trim(),
                    passwordController.text.trim());
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
                    child: Text("Sign Up",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  )),
            ),
            SizedBox(height: w * 0.1),
            RichText(
                text: TextSpan(
              text: "Sign up using one of the following methods",
              style: TextStyle(color: Colors.grey[500], fontSize: 16),
            )),
            Wrap(
                children: List<Widget>.generate(3, (index) {
              return CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white54,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("img/" + images[index]),
                  ));
            }))
          ],
        ));
  }
}
