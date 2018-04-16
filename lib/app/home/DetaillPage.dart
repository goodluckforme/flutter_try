import 'package:flutter/material.dart';

class DetaillPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new DetaillPageState();
}

class DetaillPageState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text("Detaill"),
      ),
      body: new Center(
        child: new Text("我是Detail界面"),
      ),
    );
  }
}

