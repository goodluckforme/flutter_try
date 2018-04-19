import 'package:flutter/material.dart';


class MuchDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var drawerList = <Widget>[
      new UserAccountsDrawerHeader(
        accountName: new Text("马齐"),
        accountEmail: new Text("383030056"),
        currentAccountPicture: new CircleAvatar(backgroundColor: Colors.blue,
            backgroundImage: new NetworkImage(
                "https://avatar.csdn.net/4/B/5/3_qq_20330595.jpg")),
        onDetailsPressed: () {
          Navigator.pop(context);
        },
      ),
      new ListTile(leading: new Icon(Icons.person),
        title: new Text("about me"),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).pushNamed("/About_Me");
        },
      ),
      new ListTile(
        leading: new Icon(Icons.web),
        title: new Text("CSDN"),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).pushNamed("/CSDN");
        },
      ),
      new ListTile(
        leading: new Icon(Icons.web),
        title: new Text("我的实验室"),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).pushNamed("/My_Laboratory");
        },
      )
    ];
    return new Drawer(child: new ListView(children: drawerList,));
  }
}