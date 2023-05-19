import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/const.dart';
import 'package:flutter_app/widgets/card_main.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('data');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Realtime Database Demo'),
        ),
        body: Column(
          children: [
            Expanded(
                child: Card(
              elevation: 12,
              color: Color.fromARGB(255, 193, 215, 233),
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      //title: Text('Hello'),
                      leading: const Icon(Icons.list),
                      trailing: const Text(
                        "GFG",
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                      title: Text(snapshot.value.toString()),
                      //subtitle: Text(snapshot.value.toString()),
                    );
                  }),
            )),
            Container(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  CardMain(
                    image:
                        AssetImage('img/pill_FILL0_wght400_GRAD0_opsz48.png'),
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
            )
          ],
        ));
  }
}
