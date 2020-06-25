import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
   MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
              CircleAvatar(
                radius:50.0,
                backgroundImage:AssetImage('images/avengers.jpg'),
              ),
              Text(
                'Shamanth R Nayak K',
                style:TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 20.0,
                  color:Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'AI Enthusiast',
                style:TextStyle(
                  fontFamily: 'Source Sans Pro',
                  fontSize:15.0,
                  color:Colors.teal[100],
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,

                ),
              ),
              SizedBox(
                height:30.0,
                width:150.0,
                child:Divider(
                  color:Colors.teal.shade100,
                ),
              ),
              Card(
                //color:Colors.white,
               // padding:EdgeInsets.all(10.0),
                margin:EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
                child:ListTile(
                  leading:Icon(
                    Icons.phone,
                    color:Colors.teal,

                  ),
                  title:Text(
                    '+91 9481128007',
                    style:TextStyle(
                      color:Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Card(
                //color:Colors.white,
                //padding:EdgeInsets.all(10.0),
                margin:EdgeInsets.symmetric(vertical: 10.0,horizontal: 25.0),
                child:ListTile(
                  leading:Icon(
                    Icons.email,
                    color:Colors.teal,

                  ),
                  title:Text(
                    'shamanthrnayak@gmail.com',
                    style:TextStyle(
                      color:Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 15.0,
                    ),
                  ),
                ),

              ),
            ],
          ),
        ),

      ),
    );
  }
}








