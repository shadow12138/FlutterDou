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
  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 14, right: 14, top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '今日推荐',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Text(
            '全部 11',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Container(
            margin: EdgeInsets.only(left: 2, top: 2),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget _getItem() {
    return Container(
      width: SizeUtils.getScreenWidth(),
      height: 120,
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Text(
                  '普通人的正义，以及，我们为什么要记住',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(
                  margin: EdgeInsets.only(top: 4),
                  child: Text(
                    '在这个时间点阅读阿列克谢耶维奇《切诺贝利的祭祷》并不是多么愉快',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: ImageUtils.fromHex('#7C7C7C'), fontSize: 13),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        '作者：赫恩曼尼',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: ImageUtils.fromHex('#7C7C7C'), fontSize: 11),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
          ImageUtils.getImageFromNetwork(
              'https://img3.doubanio.com/view/subject/s/public/s29803758.jpg',
              120,
              130,
              radius: 6,
              margin: EdgeInsets.only(left: 10))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        children: <Widget>[_getTitle(), _getItem()],
      ),
    );
  }
}
