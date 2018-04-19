import 'package:flutter/material.dart';
import 'package:flutter_demo/app/LaunchPage.dart';
import 'package:flutter_demo/app/home/DetaillPage.dart';
import 'package:flutter_demo/app/home/NicePage.dart';

void main() {
  runApp(
      new MaterialApp(
        title: '这是个啥?',
        routes: <String, WidgetBuilder>{
          '/NicePage': (BuildContext context) => new NicePage(),
          '/About_Me': (BuildContext context) =>
          new DetaillPage("马齐", "https://github.com/goodluckforme"),
          '/CSDN': (BuildContext context) =>
          new DetaillPage("CSDN", "https://blog.csdn.net/qq_20330595"),
          '/My_Laboratory': (BuildContext context) =>
          new DetaillPage("马儿小黑屋", "http://xiaomakj.cn/muchwp/"),
        },
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new LaunchPage(),
      )
  );
}

