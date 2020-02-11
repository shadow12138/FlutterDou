
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/file_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:rating_bar/rating_bar.dart';

class ComingFilmWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ComingFilmState();
  }
}

class ComingFilmState extends State<ComingFilmWidget> {
  List<FilmBean> films;
  double itemWidth = 104;

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 14, right: 14),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '即将上映',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(color: Color.fromARGB(255, 234, 84, 88), borderRadius: BorderRadius.all(Radius.circular(100))),
            width: 54,
            height: 20,
            alignment: Alignment.center,
            child: Text('观影指南', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),),
          ),
          Text('全部 15', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
          Container(
            margin: EdgeInsets.only(left: 2, top: 2),
            child: Icon(Icons.arrow_forward_ios, size: 12,),
          )
        ],
      ),
    );
  }

  Widget _getItem(FilmBean bean) {
    return Container(
      margin: EdgeInsets.only(right: 6, bottom: 10),
      width: itemWidth,
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          ImageUtils.getImageFromNetwork(bean.image, itemWidth, 140,
              radius: 4, alignment: Alignment.topLeft),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 4),
            child: Text(
              bean.name,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              maxLines: 1,
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 2),
              child: Text('${bean.collectCount}人想看', style: TextStyle(color: Colors.black45, fontSize: 11),)
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 2),
            child: Container(
              alignment: Alignment.center,
              width: 44,
              height: 16,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(2)), border: Border.all(color: Color.fromARGB(255, 209, 84, 100), width: 1)),
              child: Text('${bean.pubDate}', style: TextStyle(color: Color.fromARGB(255, 209, 84, 100), fontWeight: FontWeight.bold, fontSize: 8),),

            ),
          )

        ],
      ),
    );
  }

  Widget _getList() {
    if (films != null) {
      return Container(
        margin: EdgeInsets.only(left: 4),
        child: Wrap(
          children: films.map((item){
            return _getItem(item);
          }).toList(),
          spacing: 3,
        ),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: <Widget>[_getTitle(), _getList()],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    HttpUtils.getHttp(MovieUrlConfig.getComingSoon).then((val) {
      setState(() {
        films = FilmBean.getFilms(val['subjects']).sublist(0, 6);
      });
    });
  }
}
