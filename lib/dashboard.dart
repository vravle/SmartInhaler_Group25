import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     double w =MediaQuery.of(context).size.width;
    double h =MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(  
          child: GridView.extent(  
            primary: false,  
            padding: const EdgeInsets.all(16),  
            crossAxisSpacing: 10,  
            mainAxisSpacing: 10,  
            maxCrossAxisExtent: 200.0,  
            children: <Widget>[  
              SizedBox(height: 0.005,),
              SizedBox(height: 0.001,),
              Container(  
                
                padding: const EdgeInsets.all(8),  
                child: const Text('Daily Intake', style: TextStyle(fontSize: 20)),  
                color: Color.fromARGB(255, 249, 178, 86), 
              ),  
              Container(  
                padding: const EdgeInsets.all(8),  
                child: const Text('Medicine Left', style: TextStyle(fontSize: 20)),  
                color: Color.fromARGB(255, 250, 103, 152), 
              ), 
              Container(  
                padding: const EdgeInsets.all(8),  
                child: const Text('Temperature', style: TextStyle(fontSize: 20)),  
                color: Color.fromARGB(255, 250, 103, 152),  
              ),  
              Container(  
                padding: const EdgeInsets.all(8),  
                child: const Text('Humidity', style: TextStyle(fontSize: 20)),  
                color: Color.fromARGB(255, 249, 178, 86),  
              ),  
               
 
            ],  
          )),  
    );
      
  }
}