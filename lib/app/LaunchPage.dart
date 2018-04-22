import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/app/MainPage.dart';

class LaunchPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LaunchPage();
}

class _LaunchPage extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  bool isPress = true;
  int countNum = 0;

  void jumpToMain() async {
//    Navigator.of(context).pop();
    Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return new MainPage("登录");
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
    loop();
  }

  void loop() {
    new Future.delayed(const Duration(seconds: 2), () {
      if (countNum >= 3) {
        jumpToMain();
        countNum = 0;
      }
      else
        setState(() {
          countNum++;
          loop();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    var stack = new Stack(
      children: <Widget>[
        new Align(alignment: Alignment.topRight, child: new RaisedButton(
          child: new Text("${3-countNum} 跳过"),
          textColor:
          isPress ? Colors.blue : Colors.black,
          color:
          isPress ? Colors.white : Colors.blue,
          onPressed: () {
            setState(() {
              isPress = !isPress;
              jumpToMain();
            });
          },),),
      ],
    );
    var container = new Container(
        padding: const EdgeInsets.all(35.0),
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage('images/ic_launcher.jpeg')),
        ),
        child: stack
    );
    return new Scaffold(
      backgroundColor: Colors.white,
      body: container,
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text('从本地获取图像'),
//      ),
//      body: new Center(
//        child: new Container(
//          decoration: new BoxDecoration(
//            image: new DecorationImage(
//                image: new AssetImage('images/ic_launcher.jpeg')),
//          ),
//        ),
//      ),
//    );
//  }

  Future<Null> doubleClick() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('我是启动页'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('点击确认进入首页'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('确定'),
              onPressed: () {
                // 一秒以后将任务添加至event队列
                new Future.delayed(const Duration(seconds: 1), () {
                  //任务具体代码
                  jumpToMain();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}