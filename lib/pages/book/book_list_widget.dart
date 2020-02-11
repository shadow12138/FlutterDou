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
  double itemHeight = 90;

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 14, right: 14, top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '豆瓣书单',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Text(
            '全部 459',
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

  Widget _getItem(BookListBean bean, bool isLast) {
    Color borderColor = isLast ? Colors.transparent : Color.fromARGB(255, 230, 230, 230);
    return Container(
      padding: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: borderColor, width: 0.5))),
      margin: EdgeInsets.only(left: 14, right: 14, bottom: 16),
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          _getImage(bean),
          Expanded(
            child: _getDetail(bean),
          )
        ],
      ),
    );
  }
  
  Widget _getImage(BookListBean bean){
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

  Widget _getLeft(BookListBean bean) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Row(
            children: <Widget>[
              Text(
                bean.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 2, top: 1),
                  child: Text(
                    '${bean.count}本 · ${bean.collectCount}人关注',
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 14),
          child: Row(
            children: <Widget>[
              ImageUtils.getImageFromNetwork(bean.avatar, 14, 14, radius: 100),
              Container(
                margin: EdgeInsets.only(left: 4),
                child: Text(
                  bean.author,
                  style: TextStyle(
                      fontSize: 12, color: ImageUtils.fromHex('#818181')),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 2),
                child: Text(
                  '创建',
                  style: TextStyle(
                      color: ImageUtils.fromHex('#C5C5C5'), fontSize: 12),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _getDetail(BookListBean bean) {
    return Container(
      height: itemHeight,
      margin: EdgeInsets.only(left: 12),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _getLeft(bean),
              )
            ],
          )
        ],
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
    return Container(
      child: Column(
        children: <Widget>[_getTitle(), _getList()],
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
