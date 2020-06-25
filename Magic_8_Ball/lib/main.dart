import 'package:flutter/material.dart';
import 'dart:math';
void main(){
  runApp(
    MaterialApp(
      home: Ball(),
    ),
  );

}
class Ball1 extends StatefulWidget {
  @override
  _Ball1State createState() => _Ball1State();
}

class _Ball1State extends State<Ball1> {
  int ballnumber=1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: (){
          setState(() {
            ballnumber=Random().nextInt(5)+1;
            print('$ballnumber');
          });

        },
        child: Image.asset('images/ball$ballnumber.png'),
      ),
    );
  }
}

class Ball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Ask Me Anything'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      body:Ball1(),
    );
  }
}
