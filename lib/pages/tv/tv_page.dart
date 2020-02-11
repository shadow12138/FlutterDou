import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/tv/hot_entertainment_widget.dart';
import 'package:flutter_app/pages/tv/hot_tv_widget.dart';
import 'package:flutter_app/pages/tv/tv_rank_widget.dart';
import 'package:flutter_app/pages/tv/tv_recommend_widget.dart';
import 'package:flutter_app/utils/image_utils.dart';

class TvPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Column(
      children: <Widget>[
        SearchWidget(),
        HotTvWidget(),
        HotEntertainmentWidget(),
        TvRankWidget(),
        TvRecommendWidget()
      ],
    )));
  }
}

class SearchWidget extends StatelessWidget {
  List<String> searches = ['找电视', '豆瓣榜单', '豆瓣猜', '播出时间表'];
  List<String> icons = [
    'https://img3.doubanio.com/img/files/file-1531217330.png',
    'https://img1.doubanio.com/img/files/file-1531217298.png',
    'https://img1.doubanio.com/img/files/file-1531217479.png',
    'https://img9.doubanio.com/img/files/file-1531217426.png'
  ];

  double iconSize = 42;

  Widget _getItem(int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          ImageUtils.getImageFromNetwork(icons[index], iconSize, iconSize, margin: EdgeInsets.only(bottom: 4, top: 20)),
          Text(
            searches[index],
            style: TextStyle(
                fontSize: 13, color: Color.fromARGB(255, 106, 106, 106)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < searches.length; i++) {
      children.add(_getItem(i));
    }

    return Container(
      child: Row(children: children),
    );
  }
}
