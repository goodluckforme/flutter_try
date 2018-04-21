import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/app/MainPage.dart';

class LaunchPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LaunchPage();
}

class _LaunchPage extends State<StatefulWidget> {
  void jumpToMain() async {
    //Navigator.of(context).pop(true);
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

    new Future.delayed(const Duration(seconds: 2), () {
      //任务具体代码
      jumpToMain();
    });
  }

  bool isPress = false;
  int pressNum = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("启动页"),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Colors.white,
      body: new Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage('images/ic_launcher.jpeg')),
          ),
          child: new Center(
            child: new GestureDetector(
              onTap: jumpToMain,
              onDoubleTap: doubleClick,
              child: new Container(
                  alignment: Alignment.center,
                  width: 200.0,
                  height: 200.0,
                  color: Colors.transparent,
                  child: new Column(
                    children: <Widget>[
                      new Text("按钮点击次数r$pressNum"),
                      new RaisedButton(
                        child: new Text("双击LOGO进入首页"),
                        textColor:
                        pressNum % 2 == 0 ? Colors.blue : Colors.black,
                        color:
                        pressNum % 2 == 0 ? Colors.white : Colors.blue,
//                      icon: isPress ? new Icon(Icons.sync) : new Icon(
//                            Icons.alarm_on),
                        onPressed: () {
                          setState(() {
                            isPress = !isPress;
                            pressNum++;
                          });
                        },)
                    ],
                  )
              ),
            ),
          )),
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
                new Future.delayed(const Duration(seconds: 2), () {
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