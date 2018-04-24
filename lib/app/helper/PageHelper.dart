import 'dart:async';

import 'package:flutter/material.dart';

class PageHelper<Data> {
  List<Data> datas;

  int page;

  bool isinit;

  var _offset;

  double lastDownY;

  bool isFinish;

  ScrollController scrollController;

  PageHelper() {
    datas = new List();
    page = 1;
    isinit = false;
    lastDownY = 0.0;
    _offset = 0.0;
    isFinish = false;
  }

  bool handle(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      _offset = notification.metrics.extentBefore;
    }
    return false;
  }

  @override
  bool isHandle(child) {
    return child is ListView;
  }

  ScrollController createController() {
    if (scrollController == null)
      scrollController = new ScrollController(initialScrollOffset: _offset);
    return scrollController;
  }

  void jumpToLastDownY() {
    print('url========================$lastDownY');
    getController().jumpTo(lastDownY);
  }

  ScrollController getController() {
    return scrollController;
  }

  void init(Function initFunction, Function readyFunction) {
    print('url========================$isinit');
    if (!isinit) {
      initFunction();
      isinit = true;
    } else {
      readyFunction();
    }
  }

  int itemCount() {
    return datas.length;
  }

  void addData(List<Data> datas, {clear = false}) async {
    if (clear) {
      this.datas.clear();
      this.page = 1;
    }
    this.datas.addAll(datas);
    this.page++;
    isFinish = datas.isNotEmpty;
    print("---- addData  page = ${this.page}----------isFinish---$isFinish");
  }

}
