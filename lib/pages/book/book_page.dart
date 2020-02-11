import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/book/book_list_widget.dart';
import 'package:flutter_app/pages/book/book_rank_widget.dart';
import 'package:flutter_app/pages/book/book_recommend_widget.dart';
import 'package:flutter_app/pages/book/new_book_widget.dart';
import 'package:flutter_app/pages/book/today_recommend_widget.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:flutter_app/utils/size_utils.dart';

class BookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            SearchWidget(),
            NewBookWidget(),
            BookRankWidget(),
            BookListWidget(),
            TodayRecommendWidget(),
            BookRecommendWidget(),
          ],
        ),
      ),
    );
  }
}


class SearchWidget extends StatelessWidget {
  List<String> searches = ['找图书', '豆瓣榜单', '豆瓣猜', '豆瓣书单'];
  List<String> icons = [
    'https://img3.doubanio.com/img/files/file-1531217330.png',
    'https://img1.doubanio.com/img/files/file-1531217298.png',
    'https://img1.doubanio.com/img/files/file-1531217479.png',
    'https://img9.doubanio.com/img/files/file-1531217505.png'
  ];
  double iconSize = 42;

  Widget _getItem(int index) {
    return Expanded(
      child: Column(
        children: <Widget>[
          ImageUtils.getImageFromNetwork(icons[index], iconSize, iconSize, margin: EdgeInsets.only(bottom: 4, top: 20)),
          Text(searches[index], style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 106, 106, 106)),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for(int i = 0 ; i < searches.length; i++){
      children.add(_getItem(i));
    }

    return Container(
      child: Row(
          children: children
      ),
    );
  }
}

class AdvertiseWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: ImageUtils.getImageFromNetwork('https://img9.doubanio.com/view/dale-online/dale_ad/public/073fe23a91bb366.jpg', SizeUtils.getScreenWidth(), SizeUtils.getHeight(120), radius: 4, fit: BoxFit.fill),
    );
  }
}