import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final url;

  ImagePage(this.url);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
        appBar: new AppBar(
          backgroundColor: Colors.black,
        ),
        body: new Stack(
          children: <Widget>[
            new Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: new Image(image: new NetworkImage(url))
            ),
            new Align(
                alignment: FractionalOffset.bottomRight,
                child: new Container(
                    margin: new EdgeInsets.all(10.0),
                    child: new IconButton(
                      icon: new Icon(Icons.file_download),
                      color: Colors.grey,
                      onPressed: () {
                        print(url);
                      Scaffold.of(context).showSnackBar(
                            new SnackBar(content: new Text(url)));
                      },)
                )
            )
          ],
        )
    );
  }
}