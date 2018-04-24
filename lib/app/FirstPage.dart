import 'package:flutter/material.dart';
import 'package:flutter_demo/app/data/Page.dart';
import 'package:flutter_demo/app/helper/PageHelper.dart';
import 'package:flutter_demo/app/home/BasePage.dart';
import 'package:flutter_demo/app/home/NicePage.dart';
import 'package:meta/meta.dart';

class FirstPage extends BasePage {
  final userName;

  FirstPage(this.userName);

  @override
  getState() => new FirstPageState(userName);

}

class NewMainTab {
  final BasePage page;
  final Page pageInfo;
  const NewMainTab(this.pageInfo, @required this.page);
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
  var map = new Map<NewMainTab, Widget>();
  final List<NewMainTab> _allNicePages = <NewMainTab>[
    new NewMainTab(Page(icon: Icons.grade, text: 'all'), new NicePage(page: new Page(icon: Icons.grade, text: 'all'),pageHelper: new PageHelper())),
    new NewMainTab(Page(icon: Icons.favorite, text: '福利'),new NicePage(page: Page(icon: Icons.favorite, text: '福利'),pageHelper: new PageHelper())),
    new NewMainTab(Page(icon: Icons.android, text: 'Android'),new NicePage(page: Page(icon: Icons.android, text: 'Android'),pageHelper: new PageHelper())),
    new NewMainTab(Page(icon: Icons.phone_iphone, text: 'iOS'),new NicePage(page: Page(icon: Icons.phone_iphone, text: 'iOS'),pageHelper: new PageHelper())),
    new NewMainTab(Page(icon: Icons.new_releases, text: '休息视频'),new NicePage(page: Page(icon: Icons.new_releases, text: '休息视频'),pageHelper: new PageHelper())),
    new NewMainTab(Page(icon: Icons.web, text: '前端'),new NicePage(page: Page(icon: Icons.web, text: '前端'),pageHelper: new PageHelper())),
    new NewMainTab(Page(icon: Icons.video_label, text: '拓展资源'),new NicePage(page: Page(icon: Icons.video_label, text: '拓展资源'),pageHelper: new PageHelper())),
    new NewMainTab(Page(icon: Icons.assignment_turned_in, text: 'App'),new NicePage(page: Page(icon: Icons.assignment_turned_in, text: 'App'),pageHelper: new PageHelper())),
    new NewMainTab(Page(icon: Icons.subject, text: '瞎推荐'),new NicePage(page: Page(icon: Icons.subject, text: '瞎推荐'),pageHelper: new PageHelper())),
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
      bottomNavigationBar: new BottomAppBar(
        child: new TabBar(
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
          tabs: _allNicePages.map((NewMainTab tab) {
            return new Tab(
                text: tab.pageInfo.text, icon: new Icon(tab.pageInfo.icon));
          }).toList(),
        ),
        color: Colors.blue,
      ),
//      appBar: new AppBar(
//        title: new Text("$userName"),
//        bottom: new TabBar(
//          controller: controller,
//          isScrollable: true,
//          indicator: new ShapeDecoration(
//              color: Colors.black12,
//              shape: const RoundedRectangleBorder(
//                borderRadius: const BorderRadius.all(
//                    const Radius.circular(4.0)),
//                side: const BorderSide(
//                  color: Colors.transparent,
//                  width: 2.0,
//                ),
//              )
//          ),
//          tabs: _allNicePages.map((NewMainTab tab) {
//            return new Tab(
//                text: tab.pageInfo.text, icon: new Icon(tab.pageInfo.icon));
//          }).toList(),
//        ),
//      ),
      body: new TabBarView(
        physics: new NeverScrollableScrollPhysics(),
        children: _allNicePages.map((NewMainTab page) {
          var widget = map[page];
          print("widget==============$widget");
          if (widget == null) {
            widget = page.page;
            map[page] = widget;
          }
          return new Container(
              padding: const EdgeInsets.all(5.0),
//              child:page.page
              child: map[page]
          );
        }).toList(),
        controller: controller,
      ),
    );
  }
}

