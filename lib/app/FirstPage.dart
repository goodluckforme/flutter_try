import 'package:flutter/material.dart';
import 'package:flutter_demo/app/home/NicePage.dart';

class FirstPage extends StatefulWidget {
  final userName;

  FirstPage(this.userName);

  @override
  State<StatefulWidget> createState() => new FirstPageState();

}

class FirstPageState extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {

  var controller;

  //初始化底部按钮
  var titleList = [
    new Tab(child: new Text("Nice")),
    new Tab(child: new Text("Nice")),
    new Tab(child: new Text("Nice")),
  ];

  //初始化Fragment
  var tabViewList = [
    new NicePage(),
    new NicePage(),
    new NicePage()
  ];


  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("首页"),
        bottom: new TabBar(
          tabs: titleList,
          controller: controller,
        ),
      ),
      body: new TabBarView(
        children: tabViewList,
        controller: controller,
      ),
    );
  }
}
