import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/book/book_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class NewBookWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewBookState();
  }
}

class NewBookState extends State<NewBookWidget> {
  double itemWidth = 330;
  double itemHeight = 120;
  List<BookBean> books;

  Widget _getItem(BookBean bean) {
    Widget _left = ImageUtils.getImageFromNetwork(bean.image, 90, itemHeight, radius: 4, border: Border.all(color: ImageUtils.fromHex('#eeeeee'), width: 1));

    Widget _name = Container(
      child: Text(
        bean.name,
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      alignment: Alignment.topLeft,
    );
    Widget _collect = Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(
        '${bean.collectCount} 人想看 / ${bean.author}',
        style: TextStyle(
            color: ImageUtils.getTextColor3(), fontSize: 12),
      ),
    );
    Widget _comment = Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: ImageUtils.getBackgroundColor()),
      child: Text(bean.comment, style: TextStyle(color: ImageUtils.getTextColor1(), fontSize: 13)),
    );

    Widget _right = Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _name, _collect, _comment
          ],
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.only(right: 10),
      width: itemWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _left, _right
        ],
      ),
    );
  }

  Widget _getList() {
    if (books == null) return Container();
    return Container(
      height: itemHeight + 20,
      padding: EdgeInsets.only(top: 20, left: 14),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: books.map((item) {
          return _getItem(item);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _title = ImageUtils.getTitle('新书速递', count: 49, margin: EdgeInsets.symmetric(horizontal: 14));
    Widget _list = _getList();

    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[_title, _list],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getBookHttp(BookUrlConfig.getNewBooks).then((val) {
      setState(() {
        books = BookBean.getList(val);
      });
    });
  }
}
