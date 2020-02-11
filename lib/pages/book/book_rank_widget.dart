import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/book_bean.dart';
import 'package:flutter_app/model/book_rank_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';

class BookRankWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookRankState();
  }
}

class BookRankState extends State<BookRankWidget> {
  double headerHeight = 100;
  double headerWidth = 220;
  double radius = 8;
  List<BookRankBean> ranks;

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 14, right: 14, top: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '豆瓣榜单',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Text('全部 3', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
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
    if(ranks == null)
      return Container();

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

  Widget _getItem(BookRankBean bean) {
    if (bean == null) return Container();

    List<Widget> children = [];

    List<BookBean> books = bean.bookList;
    for (int i = 0; i < books.length; i++) {
      BookBean book = books[i];
      children.add(Container(
        margin: EdgeInsets.only(bottom: 10, left: 10),
        child: Row(
          children: <Widget>[
            Text(
              '${i + 1}. ${book.name} ',
              style: TextStyle(color: Colors.white),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 2),
              child: Text(
                '${book.rating}',
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

    HttpUtils.getBookHttp(BookUrlConfig.getRanks).then((val) {
      setState(() {
        ranks = BookRankBean.getList(val);
      });
    });


  }
}
