import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_demo/app/MainPage.dart';

class LaunchPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LaunchPage();
}

class _LaunchPage extends State<StatefulWidget> {
  void jumpToMain() {
//    Navigator.of(context).pop(true);
    Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return new MainPage("首页");
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return new FadeTransition(
            opacity: animation,
            child: new RotationTransition(
              turns: new Tween<double>(begin: 0.0, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }));
  }

  @override
  void initState() {
    super.initState();
  
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("启动页"),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Colors.blue,
      body: new Center(
        child: new GestureDetector(
          onTap: jumpToMain,
          child: new Container(
              color: Colors.red,
              child: new Text("如果没有跳转,请点击我", textAlign: TextAlign.center)),
        ),
      ),
    );
  }
}