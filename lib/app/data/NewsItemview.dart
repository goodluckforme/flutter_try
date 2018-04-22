import 'package:flutter/material.dart';
import 'package:flutter_demo/app/FirstPage.dart';
import 'package:flutter_demo/app/home/DetailPage.dart';
import 'package:flutter_demo/app/widget/ImagePage.dart';

class NewsItemView extends StatelessWidget {
  final title;
  final url;
  final who;
  final time;
  final type;

  NewsItemView(this.title, this.url, this.who, this.time, this.type);

  @override
  Widget build(BuildContext context) {
    var view;
    switch (type) {
      case "福利":
        var ImageContainer = new Container(
          child: new Stack(alignment: Alignment.topCenter,
            children: <Widget>[
              new Image(image: new NetworkImage(url)),
              new Positioned(left: 10.0, top: 10.0, child: new Text(
                "$time".split("T")[0],
                softWrap: true,
                style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                textAlign: TextAlign.center,
              )),
              new Align(
                  alignment: FractionalOffset.bottomRight,
                  child: new Icon(Icons.file_download, color: Colors.grey,)
              ),
            ],
          ),
        );
        view = new GestureDetector(
            child: ImageContainer,
            onTap: () async {
              Navigator.of(context).push(new PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return new ImagePage(url);
                  }));
            }
        );
        break;
      default :
        view = new Container(
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
                  "$time".split("T")[0],
                  style: new TextStyle(fontSize: 12.0),
                  textAlign: TextAlign.right,
                ),
              ],
            )
        );
        break;
    }

    return new Card(
        child: view);
  }
}