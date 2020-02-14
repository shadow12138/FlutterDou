import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/book/book_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class BookRecommendWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BookRecommendState();
  }
}

class BookRecommendState extends State<BookRecommendWidget>{
  List<BookBean> books;

  Widget _getItem(BookBean bean, bool isLast){
    Widget _left = ImageUtils.getImageFromNetwork(bean.image, 80, 100, radius: 4);

    Widget _name = Container(child: Text(bean.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),);
    Widget _rating = ImageUtils.getRating(bean.rating, margin: EdgeInsets.only(top: 4));
    Widget _desc = Container(child: Text(bean.desc, style: TextStyle(color: ImageUtils.getTextColor3()),), margin: EdgeInsets.only(top: 6),);
    Widget _tag = Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(10),
      width: 1000,
      decoration: BoxDecoration(color: ImageUtils.fromHex('#f7f7f7'), borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Text(bean.tag, )
    );

    Widget _right = Container(
      margin: EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _name, _rating, _desc, _tag
        ],
      ),
    );

    Color borderColor = isLast ? Colors.transparent : ImageUtils.getDividerColor();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: borderColor))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _left, Expanded(child: _right,)
        ],
      ),
    );
  }

  Widget _getList(){
    if(books == null)
      return Container();

    List<Widget> children = [];
    for(int i = 0; i < books.length; i++){
      children.add(_getItem(books[i], i == books.length - 1));
    }

    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
          children: children
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _title = ImageUtils.getTitle('为你推荐');
    Widget _list = _getList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[
          _title, _list
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    HttpUtils.getBookHttp(BookUrlConfig.getRecommend).then((val){
      setState(() {
        books = BookBean.getList(val);
      });
    });
  }
}