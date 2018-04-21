class GankBean {
  const GankBean(
      { this.desc, this.ganhuo_id, this.publishedAt, this.readability, this.type, this.url, this.who});

  final String desc; //还在用ListView？
  final String ganhuo_id; //57334c9d67765903fb61c418
  final String publishedAt; //2016-05-12T12:04:43.857000
  final String readability;
  final String type; //Android
  final String url; //http://www.jianshu.com/p/a92955be0a3e
  final String who; //陈宇明

  GankBean.fromJson(Map<String, dynamic> json)
      : desc = json['desc'],
        ganhuo_id = json['ganhuo_id'],
        publishedAt = json['publishedAt'],
        readability = json['readability'],
        type = json['type'],
        url = json['url'],
        who = json['who'];

  Map<String, dynamic> toJson() =>
      {
        'desc': desc,
        'ganhuo_id': ganhuo_id,
        'publishedAt': publishedAt,
        'readability': readability,
        'type': type,
        'url': url,
        'who': who,
      };
}

