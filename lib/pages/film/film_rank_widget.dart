import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/file_bean.dart';
import 'package:flutter_app/model/film_rank_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';

class FilmRankWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilmRankState();
  }
}

class FilmRankState extends State<FilmRankWidget> {
  List<FilmRankBean> ranks = [null, null, null];
  double headerHeight = 100;
  double headerWidth = 220;
  double radius = 8;

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 14, right: 14),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '豆瓣榜单',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Text('全部 10', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
          Container(
            margin: EdgeInsets.only(left: 2, top: 2),
            child: Icon(Icons.arrow_forward_ios, size: 12,),
          )
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
        children: <Widget>[_getTitle(), _getList()],
      ),
    );
  }

  Widget _getList() {
    return Container(
        margin: EdgeInsets.only(left: 14),
        height: 230,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: ranks.map((item) {
            return _getItem(item);
          }).toList(),
        ));
  }

  Widget _getItem(FilmRankBean bean) {
    if (bean == null) return Container();

    List<Widget> children = [];

    List<FilmBean> movies = bean.movies.sublist(0, 4);
    for (int i = 0; i < movies.length; i++) {
      FilmBean movie = movies[i];
      children.add(Container(
        margin: EdgeInsets.only(bottom: 10, left: 10),
        child: Row(
          children: <Widget>[
            Text(
              '${i + 1}. ${movie.name} ',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 2),
              child: Text(
                '${movie.rating}',
                style: TextStyle(color: Color.fromARGB(255, 193, 152, 91), fontSize: 12, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ));
    }

    Widget headerWidget = Stack(
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
          width: headerWidth,
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

    return Container(
      margin: EdgeInsets.only(right: 10),
      width: headerWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: bean.mainColor,
      ),
      child: Column(
        children: <Widget>[
          headerWidget,
          Container(
            margin: EdgeInsets.only(top: 14),
            child: Column(
              children: children,
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    //北美票房榜
    HttpUtils.getHttp(MovieUrlConfig.getUsBox).then((val) {
      setState(() {
        List<FilmBean> subjects = [];
        for (Map<String, dynamic> subject in val['subjects']) {
          subjects.add(FilmBean.getFilm(subject['subject']));
        }
        this.ranks[2] = FilmRankBean(
            subjects,
            '北美票房榜',
            'https://img3.doubanio.com/view/photo/l/public/p2579505354.webp',
            Color.fromARGB(255, 75, 59, 44));
      });
    });

    //一周口碑榜
    HttpUtils.getHttp(MovieUrlConfig.getWeekly).then((val) {
      setState(() {
        List<FilmBean> subjects = [];
        for (Map<String, dynamic> subject in val['subjects']) {
          subjects.add(FilmBean.getFilm(subject['subject']));
        }
        FilmRankBean bean = FilmRankBean(
            subjects,
            '一周口碑榜',
            'https://img3.doubanio.com/view/photo/l/public/p2581251453.webp',
            Color.fromARGB(255, 81, 30, 11));
        ranks[0] = bean;
      });
    });

    //新片榜
    HttpUtils.getHttp(MovieUrlConfig.getNew).then((val) {
      setState(() {
        List<FilmBean> subjects = [];
        for (Map<String, dynamic> subject in val['subjects']) {
            subjects.add(FilmBean.getFilm(subject));
        }
        FilmRankBean bean = FilmRankBean(
            subjects,
            '新片榜',
            'https://img3.doubanio.com/view/photo/l/public/p2577573812.webp',
            Color.fromARGB(255, 77, 74, 56));
        ranks[1] = bean;
      });
    });
  }
}
