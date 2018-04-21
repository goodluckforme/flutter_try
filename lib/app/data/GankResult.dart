import 'dart:convert';

import 'package:flutter_demo/app/data/GankBean.dart';

class GankResult extends JsonDecoder {
  final int count;
  final bool error;
  final List results;

  const GankResult(this.count, this.error, this.results);

  GankResult.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        error = json['error'],
        results =json['results'].map((dynamic gankBean) {
          return new GankBean.fromJson(gankBean);
        }).toList();
}

