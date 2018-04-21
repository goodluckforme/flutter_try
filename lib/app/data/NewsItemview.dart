import 'package:flutter/material.dart';
import 'package:flutter_demo/app/home/DetailPage.dart';

class NewsItemView extends StatelessWidget {
  final title;
  final url;
  final who;
  final time;

  NewsItemView(this.title, this.url, this.who, this.time);

  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new Container(
            margin: const EdgeInsets.all(10.0),
            child: new Wrap(
              alignment: WrapAlignment.end,
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    title,
                    softWrap: true,
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  subtitle: new Text(
                    "作者：$who",
                    textAlign: TextAlign.right,
                    softWrap: true,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  onTap: () {
                    Navigator.of(context).push(new PageRouteBuilder(
                        pageBuilder: (_, __, ___) {
                          return new DetailPage(title, url);
                        }));
                  },
                ),
                new Text(
                  "$time".split("T")[0] ,
                  style: new TextStyle(fontSize: 12.0),
                  textAlign: TextAlign.right,
                ),
              ],
            )
        ));
  }
}