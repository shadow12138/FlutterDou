import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/book_list.dart';
import 'package:flutter_app/model/tv_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:flutter_app/utils/size_utils.dart';
import 'package:rating_bar/rating_bar.dart';

class BookListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookListState();
  }
}

class BookListState extends State<BookListWidget> {
  List<BookListBean> bookLists;


  Widget _getItem(BookListBean bean, bool isLast) {
    Color borderColor = isLast ? Colors.transparent : ImageUtils.getDividerColor();
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderColor, width: 0.5))),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getLeft(bean), _getRight(bean)
        ],
      ),
    );
  }
  
  Widget _getLeft(BookListBean bean){
    double width = 60;
    double height = 80;
    return Container(
      child: Stack(
        children: <Widget>[
          ImageUtils.getImageFromNetwork(
              bean.images[2], width - 10, height - 10,
              radius: 4, margin: EdgeInsets.only(left: 30, top: 10)),
          ImageUtils.getImageFromNetwork(
              bean.images[1], width - 5, height - 5,
              radius: 4, margin: EdgeInsets.only(left: 15, top: 5)),
          ImageUtils.getImageFromNetwork(
              bean.images[0], width, height,
              radius: 4),
        ],
      ),
    );
  }

  Widget _getRight(BookListBean bean){
    Widget _name = Container(child: Text(bean.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),);
    Widget _collect = Container(child: Text('${bean.count}本 · ${bean.collectCount}人关注', style: TextStyle(color: ImageUtils.getTextColor2(), fontSize: 12),), margin: EdgeInsets.only(top: 8),);
    Widget _author = Container(
      margin: EdgeInsets.only(top: 14),
      child: Row(
        children: <Widget>[
          ImageUtils.getImageFromNetwork(bean.avatar, 15, 15, radius: 100),
          Text(' ${bean.author}', style: TextStyle(fontSize: 12, color: ImageUtils.getTextColor2()),),
          Text(' 创建', style: TextStyle(fontSize: 12, color: ImageUtils.getTextColor3()),)
        ],
      ),
    );

    return Container(
      margin: EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_name, _collect, _author],
      ),
    );
  }


  Widget _getList() {
    if (bookLists == null) return Container();

    List<Widget> children = [];
    for(int i = 0; i < bookLists.length; i++){
      BookListBean item = bookLists[i];
      children.add(_getItem(item, i == bookLists.length - 1));
    }

    return Container(
      child: Column(
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _title = ImageUtils.getTitle('豆瓣书单', count: 459);
    Widget _list = _getList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[_title, _list],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getBookHttp(BookUrlConfig.getLists).then((val) {
      setState(() {
        bookLists = BookListBean.getList(val);
      });
    });
  }
}
