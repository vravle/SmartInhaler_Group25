import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeDemoScreen extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.ref('data');

  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Realtime Database Demo'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 8,
            ),
            RaisedButton(
              child: Text('Read/View Data'),
              color: Colors.redAccent,
              onPressed: () {
                readData();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      )), //center
    );
  }

  void readData() {
    databaseReference.once().then((DataSnapshot snapshot) {
          print('Data : ${snapshot.value}');
        } as FutureOr Function(DatabaseEvent value));
  }

  RaisedButton(
      {required Text child,
      required MaterialAccentColor color,
      required Null Function() onPressed,
      required RoundedRectangleBorder shape}) {}
}
