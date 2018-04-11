import 'package:flutter/material.dart';

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
      body: new Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.start,
          children: <Widget>[
            new Text("我是来看看 对其方式的我是来看看 对其方式的我是来看看 对其方式的\n",
              overflow: TextOverflow.ellipsis, maxLines: 1,),
            new Center(
              child: new Text("对其方式的",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: new TextStyle(
                  letterSpacing: 10.0,
                ),),
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
  }
}