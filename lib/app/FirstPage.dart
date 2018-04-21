import 'package:flutter/material.dart';
import 'package:flutter_demo/app/home/NicePage.dart';
import 'package:flutter_demo/app/data/Page.dart';

class FirstPage extends StatefulWidget {
  final userName;

  FirstPage(this.userName);

  @override
  State<StatefulWidget> createState() => new FirstPageState(userName);

}

const List<Page> _allPages = const <Page>[
  const Page(icon: Icons.grade, text: 'All'),
  const Page(icon: Icons.playlist_add, text: '福利'),
  const Page(icon: Icons.check_circle, text: 'Android'),
  const Page(icon: Icons.question_answer, text: 'IOS'),
  const Page(icon: Icons.sentiment_very_satisfied, text: '休息视频'),
  const Page(icon: Icons.camera, text: '前端'),
  const Page(icon: Icons.assignment_late, text: '拓展视频'),
  const Page(icon: Icons.assignment_turned_in, text: 'App'),
  const Page(icon: Icons.group, text: '瞎推荐'),
];

class FirstPageState extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {

  TabController controller;
  final userName;

  FirstPageState(this.userName);

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: _allPages.length);
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
        title: new Text("$userName"),
        bottom: new TabBar(
          controller: controller,
          isScrollable: true,
          indicator: new ShapeDecoration(
              color: Colors.black12,
              shape: const RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                    const Radius.circular(4.0)),
                side: const BorderSide(
                  color: Colors.transparent,
                  width: 2.0,
                ),
              )
          ),
          tabs: _allPages.map((Page page) {
            return new Tab(text: page.text, icon: new Icon(page.icon));
          }).toList(),
        ),
      ),
      body: new TabBarView(
        children: _allPages.map((Page page) {
          return new Container(
              padding: const EdgeInsets.all(5.0),
              child: new NicePage(page: page)
          );
        }).toList(),
        controller: controller,
      ),
    );
  }
}
