import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/const.dart';
import 'package:flutter_app/widgets/card_main.dart';
import 'package:flutter_app/widgets/custom_clipper.dart';

class Streamdata extends StatefulWidget {
  const Streamdata({Key? key}) : super(key: key);
  //const Streamdata({Key? key }) : super(key: key);
  //const Streamdata({required Key? key, required this.choice}) : super(key: key);
  //final Choice choice;

  // Streamdata({
  //   required Key? key,
  //   required this.choice,
  // }) : super(key: key);

  @override
  State<Streamdata> createState() => _StreamdataState();
}

class Choice {
  const Choice({required this.title});
  final String title;
  //final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Home'),
  const Choice(title: 'Contact'),
  const Choice(title: 'Map'),
  const Choice(title: 'Phone'),
  const Choice(title: 'Camera'),
  const Choice(title: 'Setting'),
];

class _StreamdataState extends State<Streamdata> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('data');

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Stack(children: <Widget>[
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
          // appBar: AppBar(
          //   title: Text('Flutter Realtime Database Demo'),
          // ),
          Column(
            children: [
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
              Expanded(
                  child: StreamBuilder(
                stream: ref.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    Map<dynamic, dynamic> map =
                        snapshot.data!.snapshot.value as dynamic;
                    List<dynamic> list = [];
                    List<dynamic> list2 = [];
                    list.clear();
                    list = map.values.toList();
                    list2 = map.keys.toList();
                    print(map.keys);
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                        itemCount: snapshot.data!.snapshot.children.length,
                        padding: EdgeInsets.all(20),
                        itemBuilder: (context, index) {
                          var choice;
                          return GridTile(
                              //header: Text(list2[index].toString()),
                              child: new Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0)),
                            margin: EdgeInsets.all(10),
                            elevation: 7,
                            color: Constants.lightYellow,
                            //child: Text(choice.title),
                            //child: Text(map.keys.toString()),
                            //child: Text(list[index].toString()),
                            child: Column(children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                list2[index].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                list[index].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                            ]),
                          ));
                        });
                  }
                },
              )),
            ],
          )
        ]));
  }
}
