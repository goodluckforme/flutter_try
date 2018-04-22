import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/app/data/GankBean.dart';
import 'package:flutter_demo/app/data/NewsItemview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_demo/app/data/Page.dart';


class NicePage extends StatefulWidget {
  final Page page;

  NicePage({this.page});

  State<StatefulWidget> stateNicePage;

  @override
  State<StatefulWidget> createState() {
    if (stateNicePage == null) {
      print("createState===$stateNicePage");
      stateNicePage = new StateNicePage(page);
      return stateNicePage;
    } else
      return new StateNicePage(page);
  }
}

class StateNicePage extends State<StatefulWidget> {
  final Page page;

  List datas = new List();

  StateNicePage(this.page);

  int index = 1;

  @override
  void initState() {
    super.initState();
//    getJSONData();
    print("initState===$this");
  }

  Future<List<dynamic>> getJSONData() async {
    final url = "http://gank.io/api/data/${page
        .text}/20/$index";
    print('url========================$url');
    var response = await http.get(
      // Encode the url
        Uri.encodeFull(url),
        // Only accept JSON response
        headers: {"Accept": "application/json"});
    Map json = JSON.decode(response.body);
//    GankResult data = new GankResult.fromJson(json);
//    print('========================${json["results"]}');
    return json["results"];
  }

  var scrollController = new ScrollController();
  double downY = 0.0;
  double lastDownY = 0.0;
  double lastListLength = 0.0;

  @override
  Widget build(BuildContext context) {
//const cupertinoActivityIndicator = const CupertinoActivityIndicator();
    //FutureBuilder控件
    var futureBuilder = new FutureBuilder<List<dynamic>>(
      future: getJSONData(), // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
      builder: (BuildContext context, AsyncSnapshot<
          List<dynamic>> snapshot) { //snapshot就是_calculation在时间轴上执行过程的状态快照
        var loadmore = new Center(child: new Wrap(children: <Widget>[
          CupertinoActivityIndicator(),
          new Text('正在加载中...')
        ], runSpacing: 5.0));
        if (index != 1)
          loadmore = new Center(child: new SizedBox(
              width: 200.0,
              child: const LinearProgressIndicator()
          ));
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new RaisedButton(
                child: new Icon(Icons.sync),
                onPressed: () {
                  setState(() {
                    index = 1;
                  });
                }); //如果_calculation未执行则提示：请点击开始
          case ConnectionState.waiting:
            return loadmore; //如果_calculation正在执行则提示：加载中
          default: //如果_calculation执行完毕
            if (snapshot.hasError) //若_calculation执行出现异常
              return new Center(child: new Text('Error: ${snapshot.error}'));
            else { //若_calculation执行正常完成
              if (index == 1)
                datas.clear();
              else
                new Timer(new Duration(milliseconds: 200), () async {
                  scrollController.jumpTo(lastListLength);
                });
              datas.addAll(snapshot.data);
              //ListView最大长度
              return new Listener(
                  onPointerDown: (event) {
                    print("onPointerDown=====${event.down}");
                    print("onPointerDown=====${event.delta}");
                    print("onPointerDown=====${event.kind}");
                    var position = event.position.distance;
                    print("onPointerDown=====${position}");
                    downY = position;
                    print("================onPointerDown================");
                  },
                  onPointerMove: (event) {
                    var position = event.position.distance;
//                    print("onPointerMove=====${event.position}");
//                    print("onPointerMove=====${event.delta}");
                    var detal = position - lastDownY;
                    if (detal > 0) {
                      print("================向下移动================");
                    } else {
                      //所摸点长度 +滑动距离  = IistView的长度  说明到达顶部
                      print("================向上移动================");
                      print(
                          "scrollController==滑动距离=======${(position - downY)}");
                      var scrollExtent = scrollController.position
                          .maxScrollExtent;
                      print(
                          "scrollController==ListView最大长度===${scrollExtent}");
                      print("scrollController==所摸点长度===${scrollController
                          .offset}");
                      print("scrollController==所摸点离屏幕距离===${position}");
                      var result = scrollController.offset +
                          (position - downY).abs();
                      print("scrollController==result==$result");
                      if (result >= scrollExtent) {
                        print("scrollController====到达底部");
                        lastListLength = scrollExtent;
                        loadMore(scrollExtent);
                      }
                    }
                    lastDownY = position;
                  },
                  onPointerCancel: (event) {
                    print("onPointerCancel=====${event.position}");
                  },
                  onPointerUp: (event) {
//                    loadMore();
                    print("onPointerUp=====${event.position}");
                    print("onPointerUp=====${event.delta}");
                    print("onPointerDown=====${event.down}");
                  },
                  child: new ListView.builder(
                    //primary: false,
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      var data = new GankBean.fromJson(datas[index]);
                      return new NewsItemView(
                        data.desc,
                        data.url,
                        data.who,
                        data.publishedAt,
                        data.type,
                      );
                    },
                    itemCount: datas == null ? 0 : datas.length,
                  )
              );
              return new GestureDetector(
                  onPanDown: (onPanDown) {
                    print("onPanDown=====${onPanDown.globalPosition}");
                  },
                  onPanUpdate: (onPanUpdate) {
                    print("onPanUpdate=====${onPanUpdate.primaryDelta}");
                  },
                  onPanStart: (onPanStart) {
                    print("onPanStart=====${onPanStart.globalPosition}");
                  },
                  onPanEnd: (onPanEnd) {
                    print("onPanEnd=====${onPanEnd.velocity.pixelsPerSecond}");
                  },
                  onVerticalDragUpdate: (GestureDetector) {
                    var globalPosition = GestureDetector.delta;
                    print("onVerticalDragUpdate=====$globalPosition");
                  },
                  onVerticalDragDown: (GestureDetector) {
                    var globalPosition = GestureDetector.globalPosition;
                    print("onVerticalDragDown=====$globalPosition");
                  },
                  onVerticalDragStart: (GestureDetector) {
                    var globalPosition = GestureDetector.globalPosition;
                    print("onVerticalDragStart=====$globalPosition");
                  },
                  onVerticalDragCancel: () {
                    print("onVerticalDragCancel=====");
                  },
                  onVerticalDragEnd: (GestureDetector) {
                    print("onHorizontalDragEnd=====${GestureDetector.velocity
                        .pixelsPerSecond}");
                  },
                  child: new ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var data = new GankBean.fromJson(snapshot.data[index]);
                      return new NewsItemView(
                        data.desc,
                        data.url,
                        data.who,
                        data.publishedAt,
                        data.type,
                      );
                    },
                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                  )
              );
            }
            return new ListView.builder(
              primary: false,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var data = new GankBean.fromJson(snapshot.data[index]);
                return new NewsItemView(
                  data.desc,
                  data.url,
                  data.who,
                  data.publishedAt,
                  data.type,
                );
              },
              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            );
        }
      },
    );
    var refreshIndicator = new RefreshIndicator(
      //RefreshIndicator的子元素必须是一个可以滚动的控件
      //如果你遇到不符合条件的控件，请将其用可以滚动的控件（如ListView、PageView等）包装一下
      child: Stack(
          children: <Widget>[
            futureBuilder,
            new Align(
              alignment: Alignment.bottomRight,
              child: new FloatingActionButton(
                  tooltip: "去顶部",
                  child: new Container(
                    child: new Icon(Icons.arrow_upward),
                  ),
                  onPressed: () {
                    scrollController.jumpTo(50.0);
                  }
              ),
            )
          ]
      ),
      onRefresh: () async {
        index = 1;
        setState(() {});
      }, //onRefresh的回调必须是一个Future<Null>类型
    );
    return refreshIndicator;
  }

  void loadMore(double maxScrollExtent) {
    setState(() {
      index++;
    });
  }
}

