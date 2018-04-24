import 'dart:async';
import 'dart:math';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/app/data/GankBean.dart';
import 'package:flutter_demo/app/data/NewsItemview.dart';
import 'package:flutter_demo/app/helper/PageHelper.dart';
import 'package:flutter_demo/app/home/BasePage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_demo/app/data/Page.dart';


class NicePage extends BasePage {
  final Page page;
  final PageHelper pageHelper;

  const NicePage({this.page, this.pageHelper});

  @override
  getState() => new StateNicePage(page: page, helper: pageHelper);

  PageHelper getPageHelper() {
    return pageHelper;
  }
}

//PageHelper helper = new PageHelper();

class StateNicePage extends State<StatefulWidget> {
  final Page page;
  final PageHelper helper;

  StateNicePage({this.page, this.helper});

  double downY = 0.0;
  double lastDownY = 0.0;
  double lastListLength = 0.0;

  @override
  void initState() {
    super.initState();
    print('===========initState============');
    helper.init(() {
      getJSONData();
    }, () {
      new Timer(new Duration(milliseconds: 150), () {
        helper.jumpToLastDownY();
      });
    });
  }

  Future getJSONData() async {
    final url = "http://gank.io/api/data/${page
        .text}/10/${helper.page}";
    print('url========================$url');
    var response = await http.get(
        Uri.encodeFull(url),
        headers: {"Accept": "application/json"});
    Map json = JSON.decode(response.body);
    if (helper.page == 1) {
      helper.datas.clear();
    }
    new Timer(new Duration(milliseconds: 500), () {
      setState(() {
        helper.addData(json["results"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //const cupertinoActivityIndicator = const CupertinoActivityIndicator();
    //FutureBuilder控件
    var listener = new Listener(
        onPointerDown: (event) {
          var position = event.position.distance;
          downY = position;
        },
        onPointerMove: (event) {
          var position = event.position.distance;
          var detal = position - lastDownY;
          if (detal > 0) {
            print("================向下移动================");
          } else {
            //所摸点长度 +滑动距离  = IistView的长度  说明到达底部
            print("================向上移动================");
            var scrollExtent = helper
                .getController()
                .position
                .maxScrollExtent;
            var result = helper
                .getController()
                .offset +
                (position - downY).abs();
            if (result >= scrollExtent) {
              print("scrollController====到达底部");
              lastListLength = scrollExtent;
              loadMore(scrollExtent);
            }
            helper.lastDownY = result;
          }
          lastDownY = position;
        },

        child: new ListView.builder(
          //primary: false,
          physics: const AlwaysScrollableScrollPhysics(),
          controller: helper.createController(),
          itemBuilder: (BuildContext context, int index) {
            var data = new GankBean.fromJson(helper.datas[index]);
            return new NewsItemView(
              data.desc,
              data.url,
              data.who,
              data.publishedAt,
              data.type,
            );
          },
          itemCount: helper.datas == null ? 0 : helper.datas.length,
        )
    );

    var refreshIndicator = new RefreshIndicator(
      //RefreshIndicator的子元素必须是一个可以滚动的控件
      //如果你遇到不符合条件的控件，请将其用可以滚动的控件（如ListView、PageView等）包装一下
      child: Stack(
          children: <Widget>[
            listener,
            new Align(
              alignment: Alignment.bottomRight,
              child: new FloatingActionButton(
                  tooltip: "去顶部",
                  child: new Container(
                    child: new Icon(Icons.arrow_upward),
                  ),
                  onPressed: () {
                    helper.getController().jumpTo(10.0);
                  }
              ),
            )
          ]
      ),
      onRefresh: () async {
        helper.page = 1;
        getJSONData();
      }, //onRefresh的回调必须是一个Future<Null>类型
    );
    return refreshIndicator;
  }

  void loadMore(double maxScrollExtent) {
    print("=========loadMore=======${helper.isFinish}");
    if (helper.isFinish) {
      helper.isFinish = false;
      getJSONData();
    };
  }
}
//    var futureBuilder = new FutureBuilder<String>(
//      future: isInit(), // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
//      builder: (BuildContext context,
//          AsyncSnapshot<
//              String> snapshot) { //snapshot就是_calculation在时间轴上执行过程的状态快照
//        var loadmore = new Center(child: new Wrap(children: <Widget>[
//          CupertinoActivityIndicator(),
//          new Text('正在加载中...')
//        ], runSpacing: 5.0));
//        if (_helper.page != 1)
//          loadmore = new Center(child: new SizedBox(
//              width: 200.0,
//              child: const LinearProgressIndicator()
//          ));
//        switch (snapshot.connectionState) {
//          case ConnectionState.none:
//            return new RaisedButton(
//                color: Colors.blue,
//                child: new Icon(Icons.sync),
//                onPressed: () {
//                  _helper.page = 1;
//                  index = 1;
//                  getJSONData();
//                }); //如果_calculation未执行则提示：请点击开始
//          case ConnectionState.waiting:
//            return loadmore; //如果_calculation正在执行则提示：加载中
//          default: //如果_calculation执行完毕
//            if (snapshot.hasError) //若_calculation执行出现异常
//              return new Center(child: new Text('Error: ${snapshot.error}'));
//            else { //若_calculation执行正常完成
//              print("snapshot===========$snapshot");
//              //ListView最大长度
//              return listener;
//            }
//        }
//      },
//    );
//  Future<String> isInit() async {
//    return "";
//  }
//              return new GestureDetector(
//                  onPanDown: (onPanDown) {
//                    print("onPanDown=====${onPanDown.globalPosition}");
//                  },
//                  onPanUpdate: (onPanUpdate) {
//                    print("onPanUpdate=====${onPanUpdate.primaryDelta}");
//                  },
//                  onPanStart: (onPanStart) {
//                    print("onPanStart=====${onPanStart.globalPosition}");
//                  },
//                  onPanEnd: (onPanEnd) {
//                    print("onPanEnd=====${onPanEnd.velocity.pixelsPerSecond}");
//                  },
//                  onVerticalDragUpdate: (GestureDetector) {
//                    var globalPosition = GestureDetector.delta;
//                    print("onVerticalDragUpdate=====$globalPosition");
//                  },
//                  onVerticalDragDown: (GestureDetector) {
//                    var globalPosition = GestureDetector.globalPosition;
//                    print("onVerticalDragDown=====$globalPosition");
//                  },
//                  onVerticalDragStart: (GestureDetector) {
//                    var globalPosition = GestureDetector.globalPosition;
//                    print("onVerticalDragStart=====$globalPosition");
//                  },
//                  onVerticalDragCancel: () {
//                    print("onVerticalDragCancel=====");
//                  },
//                  onVerticalDragEnd: (GestureDetector) {
//                    print("onHorizontalDragEnd=====${GestureDetector.velocity
//                        .pixelsPerSecond}");
//                  },
//                  child: new ListView.builder(
//                    physics: const ClampingScrollPhysics(),
//                    itemBuilder: (BuildContext context, int index) {
//                      var data = new GankBean.fromJson(snapshot.data[index]);
//                      return new NewsItemView(
//                        data.desc,
//                        data.url,
//                        data.who,
//                        data.publishedAt,
//                        data.type,
//                      );
//                    },
//                    itemCount: snapshot.data == null ? 0 : snapshot.data.length,
//                  )
//              );
//            return new ListView.builder(
//              primary: false,
//              physics: const ScrollPhysics(),
//              itemBuilder: (BuildContext context, int index) {
//                var data = new GankBean.fromJson(snapshot.data[index]);
//                return new NewsItemView(
//                  data.desc,
//                  data.url,
//                  data.who,
//                  data.publishedAt,
//                  data.type,
//                );
//              },
//              itemCount: snapshot.data == null ? 0 : snapshot.data.length,
//            );