import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/app/FirstPage.dart';
import 'package:flutter_demo/app/home/DetailPage.dart';
import 'package:flutter_demo/app/widget/MuchDrawer.dart';

class MainPage extends StatefulWidget {
  final String title;

  MainPage(this.title);

  @override
  MainPagePageState createState() => new MainPagePageState();
}

class MainPagePageState extends State<MainPage> {
  bool _isFavorited = false;
  int count = 0;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String userName = "";
  String passWord = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(widget.title),
        ),
        drawer: new Drawer(
          child: new MuchDrawer(),
        ),
        body: new SingleChildScrollView(
            padding: new EdgeInsets.all(24.0),
            child: new Column(
                children: <Widget>[
                  new Text("Flutter_Gank", style: new TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal
                  ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.clip,
                      maxLines: 1),
                  new GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isFavorited)
                            _isFavorited = false;
                          else
                            _isFavorited = true;
                        });
                      },
                      child: new Container(
                          margin: const EdgeInsets.all(20.0),
                          width: 100.0,
                          height: 100.0,
                          color: Colors.white70,
                          child: new Image(
                              image: new AssetImage('images/ic_launcher.jpeg'))
                      )
                  ),
                  new TextField(
                    autocorrect: true,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: "用户名/手机号/邮箱",
                        helperText: "MUCH",
                        helperStyle: new TextStyle(
                            color: Colors.grey
                        )
                    ),
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    maxLength: 12,
                    maxLines: 1,
                    onSubmitted: (String value) {
                      userName = value;
                    },
                  ),
                  new TextField(
                    autocorrect: true,
                    decoration: new InputDecoration(
                        labelText: "密码",
                        helperText: "123456",
                        helperStyle: new TextStyle(
                            color: Colors.grey
                        )
                    ),
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    onSubmitted: (String value) {
                      passWord = value;
                    },
                  ),
                  new RaisedButton(
                      onPressed: checkAndLogin,
                      color: Colors.blue,
                      highlightColor: Colors.lightBlueAccent,
                      disabledColor: Colors.lightBlueAccent,
                      child: new Text(
                        "登录",
                        style: new TextStyle(color: Colors.white),
                      ))
                ])),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            count++;
            print("count=====================$count");
            if (count >= 5) {
              _scaffoldKey.currentState.showSnackBar(new SnackBar(
                content: new Text("这个按钮没啥用,不要再点了"),
                duration: new Duration(seconds:5),
                action: new SnackBarAction(
                    label: "要去首页吗？", onPressed: () {
                  Navigator.of(context).push(new PageRouteBuilder(
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return new FirstPage(userName);
                      }));
                }),));
              count = 0;
            }
          },
          tooltip: '大爷点我呀！',
          child: new Icon(Icons.ac_unit),
        )
    );
  }

  void showToast() {
    showDialog <Null>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
              content: new Text("皮一下很开心", style: new TextStyle(
                  textBaseline: TextBaseline.alphabetic,
                  color: Colors.blue,
                  fontSize: 16.0
              ),),
              title: new Text("其实什么都不输入可直接进入首页哈哈", style: new TextStyle(
                inherit: true,
                color: Colors.redAccent,
                fontSize: 18.0,
                decoration: TextDecoration.lineThrough,
              ),),
              actions: <Widget>[
                new FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    highlightColor: Colors.lightBlueAccent,
                    disabledColor: Colors.lightBlueAccent,
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                          new PageRouteBuilder(
                              pageBuilder: (_, __, ___) {
                                return new DetailPage(
                                    "马齐", "https://github.com/goodluckforme");
                              }
                          ));
                    },
                    child: new Text('查看作者')
                ),
                new FlatButton(
                    textColor: Colors.grey,
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(new PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return new FirstPage(userName);
                          }));
                    },
                    child: new Text('去首页')
                )
              ]
          );;
        });
  }

  void checkAndLogin() {
    if ("MUCH".compareTo(userName) == 1 && "123456".compareTo(passWord) == 1) {
      showToast();
    } else
      showDialog<Null>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return new AlertDialog(
            content: SingleChildScrollView(
              child: new Form(
                  key: _formKey,
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          icon: const Icon(Icons.phone),
                          hintText: '用户名/手机号/邮箱',
                          labelText: 'Phone Number *',
                          prefixText: '+86',
                        ),
                        keyboardType: TextInputType.phone,
                        onSaved: (String value) {
                          userName = value;
                        },
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                      ),
                      new TextFormField(
                        decoration: const InputDecoration(
                          border: const UnderlineInputBorder(),
                          filled: true,
                          icon: const Icon(Icons.security),
                          hintText: '密码',
                          labelText: 'PassWord',
                          prefixText: '',
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (String value) {
                          passWord = value;
                        },
                        inputFormatters: <TextInputFormatter>[
                          //WhitelistingTextInputFormatter.digitsOnly,
                          BlacklistingTextInputFormatter.singleLineFormatter
                        ],
                      ),
                    ],
                  )
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('登录'),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    _scaffoldKey.currentState.showSnackBar(
                        new SnackBar(content: new Text("登录成功")));
                    Navigator.of(context).push(new PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return new FirstPage(userName);
                        }));
                  } else {
                    _scaffoldKey.currentState.showSnackBar(
                        new SnackBar(content: new Text("登录失败，用户名密码有误")));
                  }
                },
              ),
              new FlatButton(
                child: new Text('重置'),
                onPressed: () {
                  _formKey.currentState.reset();
                },
              ),
            ],
          );
        },
      );
  }
}
