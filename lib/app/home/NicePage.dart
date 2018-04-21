import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/app/data/GankBean.dart';
import 'package:flutter_demo/app/data/GankResult.dart';
import 'package:flutter_demo/app/data/NewsItemview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_demo/app/data/Page.dart';


class NicePage extends StatefulWidget {
  final Page page;

  NicePage({this.page});

  @override
  State<StatefulWidget> createState() => new StateNicePage(page);
}

class StateNicePage extends State<StatefulWidget> {
  final Page page;

  StateNicePage(this.page);

  int index = 1;

  @override
  void initState() {
    super.initState();
//    getJSONData();
  }

  Future<List<dynamic>> getJSONData() async {
    final url = "http://gank.io/api/search/query/listview/category/${page
        .text}/count/10/page/$index";
    var response = await http.get(
      // Encode the url
        Uri.encodeFull(url),
        // Only accept JSON response
        headers: {"Accept": "application/json"});
    Map json = JSON.decode(response.body);
//    GankResult data = new GankResult.fromJson(json);
    print('========================${json["results"]}');
    return json["results"];
  }

  @override
  Widget build(BuildContext context) {
//const cupertinoActivityIndicator = const CupertinoActivityIndicator();
    var scrollController = new ScrollController();
    //FutureBuilder控件
    var futureBuilder = new FutureBuilder<List<dynamic>>(
      future: getJSONData(), // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
      builder: (BuildContext context, AsyncSnapshot<
          List<dynamic>> snapshot) { //snapshot就是_calculation在时间轴上执行过程的状态快照
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Center(child: new Wrap(children: <Widget>[
              CupertinoActivityIndicator(),
              new Text(
                  'Press button to start')
            ], runSpacing: 5.0)); //如果_calculation未执行则提示：请点击开始
          case ConnectionState.waiting:
            return
              new Center(child: new Wrap(children: <Widget>[
                CupertinoActivityIndicator(),
                new Text(
                    'Awaiting result...')
              ])); //如果_calculation正在执行则提示：加载中
          default: //如果_calculation执行完毕
            if (snapshot.hasError) //若_calculation执行出现异常
              return new Center(child: new Text('Error: ${snapshot.error}'));
            else //若_calculation执行正常完成
              return new ListView.builder(
                physics: const ScrollPhysics(),
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  var data = new GankBean.fromJson(snapshot.data[index]);
                  //var data = snapshot.data[index];
                  return new NewsItemView(
                    data.desc,
                    data.url,
                    data.who,
                    data.publishedAt,);
                },
                itemCount: snapshot.data == null ? 0 : snapshot.data.length,
              );
        }
      },
    );
    var refreshIndicator = new RefreshIndicator(
      //RefreshIndicator的子元素必须是一个可以滚动的控件
      //如果你遇到不符合条件的控件，请将其用可以滚动的控件（如ListView、PageView等）包装一下
      child: futureBuilder,
      onRefresh: () async {
        setState(() {});
      }, //onRefresh的回调必须是一个Future<Null>类型
    );
    return refreshIndicator;
  }
}

