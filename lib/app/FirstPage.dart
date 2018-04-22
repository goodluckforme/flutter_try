import 'package:flutter/material.dart';
import 'package:flutter_demo/app/home/NicePage.dart';
import 'package:flutter_demo/app/data/Page.dart';

class FirstPage extends StatefulWidget {
  final userName;

  FirstPage(this.userName);

  @override
  State<StatefulWidget> createState() => new FirstPageState(userName);

}

//const List<Page> _allPages = const <Page>[
//  const Page(icon: Icons.grade, text: 'all'),
//  const Page(icon: Icons.favorite, text: '福利'),
//  const Page(icon: Icons.android, text: 'Android'),
//  const Page(icon: Icons.phone_iphone, text: 'iOS'),
//  const Page(icon: Icons.new_releases, text: '休息视频'),
//  const Page(icon: Icons.web, text: '前端'),
//  const Page(icon: Icons.video_label, text: '拓展资源'),
//  const Page(icon: Icons.assignment_turned_in, text: 'App'),
//  const Page(icon: Icons.subject, text: '瞎推荐'),
//];

class FirstPageState extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {

  final List<NicePage> _allNicePages = <NicePage>[
    NicePage(page: Page(icon: Icons.grade, text: 'all')),
    NicePage(page: Page(icon: Icons.favorite, text: '福利')),
    NicePage(page: Page(icon: Icons.android, text: 'Android')),
    NicePage(page: Page(icon: Icons.phone_iphone, text: 'iOS')),
    NicePage(page: Page(icon: Icons.new_releases, text: '休息视频')),
    NicePage(page: Page(icon: Icons.web, text: '前端')),
    NicePage(page: Page(icon: Icons.video_label, text: '拓展资源')),
    NicePage(page: Page(icon: Icons.assignment_turned_in, text: 'App')),
    NicePage(page: Page(icon: Icons.subject, text: '瞎推荐')),
  ];

  TabController controller;
  final userName;

  FirstPageState(this.userName);

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: _allNicePages.length);
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
          tabs: _allNicePages.map((NicePage page) {
            return new Tab(
                text: page.page.text, icon: new Icon(page.page.icon));
          }).toList(),
        ),
      ),
      body: new TabBarView(
        children: _allNicePages.map((NicePage page) {
          return new Container(
              padding: const EdgeInsets.all(5.0),
              child: page
          );
        }).toList(),
        controller: controller,
      ),
    );
  }
}
