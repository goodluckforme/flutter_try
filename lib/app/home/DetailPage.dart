import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DetailPage extends StatelessWidget {
  final String url;
  final String title;

  DetailPage(this.title, this.url);

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      //把头去掉更自然点
      appBar: new AppBar(
        title: new Text(title),
      ),
      url: url,
      withJavascript: true,
    );
  }
}

