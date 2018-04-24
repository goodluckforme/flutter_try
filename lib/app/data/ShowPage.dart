import 'package:flutter/material.dart';
import 'package:flutter_demo/app/home/BasePage.dart';

class ShowPage extends BasePage {
  @override
  getState() => new _ShowPageState();
}

class _ShowPageState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Image(image: new AssetImage(('images/ic_launcher.jpeg'))),
    );
  }
}