import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/book_bean.dart';
import 'package:flutter_app/model/file_bean.dart';
import 'package:flutter_app/model/film_rank_bean.dart';
import 'package:flutter_app/model/tv_bean.dart';
import 'package:flutter_app/model/tv_rank_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class NewBookWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewBookState();
  }
}

class NewBookState extends State<NewBookWidget> {
  double itemHeight = 130;
  double itemWidth = 330;

  List<BookBean> books;

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 14, right: 14, top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '新书速递',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Text(
            '全部 49',
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


  Widget _getItem(BookBean bean) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: itemWidth,
      child: Row(
        children: <Widget>[
          Container(
            height: itemHeight,
            padding: EdgeInsets.only(bottom: itemHeight - 120),
//            color: Colors.pink,
            child: ImageUtils.getImageFromNetwork(bean.image, 90, 120,
                radius: 4,
                border:
                Border.all(color: ImageUtils.fromHex('#eeeeee'), width: 1)),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      bean.name,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4, bottom: 20),
                    child: Text(
                      '${bean.collectCount} 人想看 / ${bean.author}',
                      style: TextStyle(
                          color: ImageUtils.fromHex('#929292'), fontSize: 12),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                              color: ImageUtils.fromHex('#eeeeee'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Text(
                            bean.comment,
                            style: TextStyle(color: Colors.black),
                            maxLines: 2,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getList() {
    if (books == null) return Container();
    return Container(
      padding: EdgeInsets.only(left: 14),
      height: itemHeight,
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
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        children: <Widget>[_getTitle(), _getList()],
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
