import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/file_bean.dart';
import 'package:flutter_app/model/film_rank_bean.dart';
import 'package:flutter_app/model/tv_bean.dart';
import 'package:flutter_app/model/tv_rank_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class TvRankWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TvRankState();
  }
}

class TvRankState extends State<TvRankWidget> {
  double itemHeight = 230;
  double itemWidth = 220;
  double radius = 8;
  List<TvRankBean> ranks;

  @override
  Widget build(BuildContext context) {
    Widget _title = ImageUtils.getTitle('豆瓣榜单', count:  9, margin: EdgeInsets.symmetric(horizontal: 14));
    Widget _list = _getList();

    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[_title, _list,]
      ),
    );
  }

  Widget _getList() {
    if(ranks == null)
      return Container();

    return Container(
      margin: EdgeInsets.only(top: 20, left: 14),
        height: itemHeight,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: ranks.map((item) {
            return _getItem(item);
          }).toList(),
        ));
  }

  Widget _getItem(TvRankBean bean) {
    List<Widget> children = [];

    List<TvBean> tvs = bean.tvList;
    for (int i = 0; i < tvs.length; i++) {
      TvBean tv = tvs[i];

      Widget _name = Text(
        '${i + 1}. ${tv.name} ',
        style: TextStyle(color: Colors.white),
      );
      Widget _rating = Container(
        margin: EdgeInsets.only(top: 2, left: 2),
        child: Text(
          '${tv.rating}',
          style: TextStyle(color: Color.fromARGB(255, 193, 152, 91), fontSize: 12, fontWeight: FontWeight.bold),
        ),
      );

      children.add(Container(
        margin: EdgeInsets.only(bottom: 10, left: 10),
        child: Row(
          children: <Widget>[_name, _rating],
        ),
      ));
    }

    double headerHeight = itemHeight * 0.4;
    Widget _header = Stack(
      children: <Widget>[
        Container(
          height: headerHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius)),
              image: DecorationImage(
                  image: NetworkImage(bean.image), fit: BoxFit.cover)),
        ),
        Container(
          width: itemWidth,
          height: headerHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radius),
                  topRight: Radius.circular(radius)),
              color: Color.fromARGB(88, 0, 0, 0)),
          child: Container(
            margin: EdgeInsets.only(left: 20, top: headerHeight / 2),
            child: Text(
              bean.title,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        )
      ],
    );

    Widget _content = Container(
      margin: EdgeInsets.only(top: 14),
      child: Column(
        children: children,
      ),
    );

    return Container(
      margin: EdgeInsets.only(right: 10),
      width: itemWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: bean.mainColor,
      ),
      child: Column(
        children: <Widget>[
          _header, _content
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getTvHttp(TvUrlConfig.getRanks).then((val) {
      setState(() {
        ranks = TvRankBean.getList(val);
      });
    });


  }
}
