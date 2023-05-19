import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class readData extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<readData> {
  void initState() {
    super.initState();
    readData();
  }

  bool isLoading = true;
  List<double> list = [];
  Future<void> readData() async {
    // Please replace the Database URL
    // which we will get in “Add Realtime Database”
    // step with DatabaseURL

    var url =
        "https://flutter-app-da0ad-default-rtdb.firebaseio.com/" + "data.json";
    // Do not remove “data.json”,keep it as it is
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((ID, data) {
        list.add(data);
      });
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RealTime Database',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("GeeksforGeeks"),
          ),
          body: isLoading
              ? const CircularProgressIndicator()
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 50,
                        child: Center(
                          child: Text(
                            list[index].toString(),
                            style: TextStyle(color: Colors.green),
                          ),
                        ));
                  })),
    );
  }
}
