import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '这是个啥?',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new OthersPage("哈哈"),
    );
  }
}

class OthersPage extends StatefulWidget {
  final String title;

  OthersPage(this.title);

  @override
  _OthersPageState createState() => new _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  int _counter = 10;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Wrap(
          direction: Axis.vertical,
          children: <Widget>[
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
                        child: new Text(
                            "当前支持$_counter行\n输入一段文本输入一段文本输入一段文本输入一段文本输入一段文本输入一段文本输入一段文本输入一段文本输入一段文本输入一段文本输入一段文本输入一段文本\n换一行试试\n再换一行试试")
                    ))
            )
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
    setState(() {
      _counter++;
    });
  }
}

