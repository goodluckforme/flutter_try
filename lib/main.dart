import 'package:flutter/material.dart';
import 'package:flutter_demo/app/MainPage.dart';

void main() {
  runApp(
      new MaterialApp(
        title: '这是个啥?',
        theme: new ThemeData(
          primarySwatch: Colors.lime,
        ),
        home: new MainPage("哈哈"),
      )
  );
}