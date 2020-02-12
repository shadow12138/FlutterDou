import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/book_bean.dart';
import 'package:flutter_app/model/book_rank_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:flutter_app/utils/size_utils.dart';

class TodayRecommendWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodayRecommendState();
  }
}

class TodayRecommendState extends State<TodayRecommendWidget> {

  Widget _getItem() {
    String title = '普通人的正义，以及，我们为什么要记住？';
    String desc = '在这个时间点阅读阿列克谢耶维奇《切诺贝利的祭祷》并不是多么愉快';
    String author = '赫恩曼尼';

    Widget _right = ImageUtils.getImageFromNetwork(
        'https://img3.doubanio.com/view/subject/s/public/s29803758.jpg',
        110,
        110,
        radius: 6,
        margin: EdgeInsets.only(left: 10));

    Widget _title = Container(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),);
    Widget _desc = Container(child: Text(desc, style: TextStyle(color: ImageUtils.getTextColor2(), fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis,), margin: EdgeInsets.only(top: 6),);
    Widget _author = Container(child: Text('作者：$author', style: TextStyle(color: ImageUtils.getTextColor3(), fontSize: 12), ), margin: EdgeInsets.only(top: 6),);

    Widget _left = Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title, _desc, _author
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_left, _right],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _title = ImageUtils.getTitle('今日推荐', count: 11);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: <Widget>[_title, _getItem()],
      ),
    );
  }
}
