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
  int _counter = 8;
  bool _isFavorited = false;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String userName = "";
  String passWord = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
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
            new RaisedButton(
                onPressed: checkAndLogin,
                color: Colors.blue,
                highlightColor: Colors.lightBlueAccent,
                disabledColor: Colors.lightBlueAccent,
                child: new Text(
                  "登录",
                  style: new TextStyle(color: Colors.white),
                ))
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
              return new DetailPage("马齐", "https://github.com/goodluckforme");
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

  void checkAndLogin() {
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
//                        WhitelistingTextInputFormatter.digitsOnly,
                        BlacklistingTextInputFormatter.singleLineFormatter
                      ],
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
                      keyboardType: TextInputType.phone,
                      maxLength: 12,
                      maxLines: 1,
                      onSubmitted: (String value) {
                        userName = value;
                        showToast();
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
                        showToast();
                      },
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
