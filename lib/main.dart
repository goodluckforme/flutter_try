import 'package:flutter/material.dart';
import 'package:flutter_demo/app/MainPage.dart';
import 'package:flutter_demo/app/home/NicePage.dart';
import 'package:flutter_demo/app/home/DetaillPage.dart';

void main() {
  runApp(
      new MaterialApp(
        title: '这是个啥?',
        routes: <String, WidgetBuilder>{
          '/NicePage': (BuildContext context) => new NicePage(),
          '/DetaillPage': (BuildContext context) => new DetaillPage(),
        },
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MainPage("哈哈"),
      )
  );
}

