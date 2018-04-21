import 'package:flutter/material.dart';
import 'package:flutter_demo/app/FirstPage.dart';
import 'package:flutter_demo/app/home/DetaillPage.dart';
import 'package:flutter_demo/app/widget/MuchDrawer.dart';

class MainPage extends StatefulWidget {
  final String title;

  MainPage(this.title);

  @override
  MainPagePageState createState() => new MainPagePageState();
}

class MainPagePageState extends State<MainPage> {
  int _counter = 8;
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      drawer: new Drawer(
        child: new MuchDrawer(),
      ),
      body: new Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: <Widget>[
            new Text("这只是一个启动页你信吗?\n",
              overflow: TextOverflow.ellipsis, maxLines: 1,),
            new GestureDetector(
              onTap: showToast,
              child: new Center(
                child: new Text("对齐方式",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: new TextStyle(
                    letterSpacing: 10.0,
                  ),),
              ),
            ),

            new GestureDetector(
                onTap: buttonClick,
                onDoubleTap: doubeClick,
                child: new Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.pink,
                    child: new Icon(
                        _isFavorited ? Icons.favorite : Icons
                            .do_not_disturb_alt)
                )
            ),
            new Container(
                alignment: Alignment.center,
                child: new Directionality(
                    textDirection: TextDirection.ltr,
                    child: new DefaultTextStyle(
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.black38,
                            decoration: TextDecoration.none
                        ),
                        maxLines: _counter < 0 ? 0 : _counter,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        child: new Text("我是来占位置的")
                    ))
            ),
            new Builder(builder: (BuildContext context) {
              return new RaisedButton(
                  onPressed: () {
                    var userName = "1234";
                    var passWord = "123";
                    if (userName == passWord) {
                      Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return new FirstPage(userName);
                          }));
                    } else {
                      Scaffold.of(context).showSnackBar(
                          new SnackBar(content: new Text("登录失败，用户名密码有误")));
                      onTextClear();
                    }
                  },
                  color: Colors.blue,
                  highlightColor: Colors.lightBlueAccent,
                  disabledColor: Colors.lightBlueAccent,
                  child: new Text(
                    "登录",
                    style: new TextStyle(color: Colors.white),
                  ));
            })
          ]),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '大爷点我呀！',
        child: new Icon(Icons.ac_unit),
      )
      ,
    );
  }

  void _incrementCounter() {
    if (_counter == 10) {} else
      setState(() {
        _counter++;
      });
  }

  void buttonClick() {
    setState(() {
      print("我被点击了");
      if (_isFavorited)
        _isFavorited = false;
      else
        _isFavorited = true;
    });
  }

  void doubeClick() {
    print("我被双击了!");
    //Navigator.of(context).pop();
    Navigator.of(context).pushNamed("/NicePage");
  }

  void onTextClear() {
    //Navigator.of(context).pushNamed("/DetaillPage");
    Navigator.of(context).push(
        new PageRouteBuilder(
            pageBuilder: (_, __, ___) {
              return new DetaillPage("马齐", "https://github.com/goodluckforme");
            }
        ));
  }

  void showToast() {
    showDialog<Null>(
        context: context,
        child: new AlertDialog(
            content: new Text("皮一下很开心"),
            title: new Text("皮一下很开心"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text('确定')
              )
            ]
        )
    );
  }
}

