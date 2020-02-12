
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/file_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:rating_bar/rating_bar.dart';

class HotFilmWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotFilmState();
  }
}

class HotFilmState extends State<HotFilmWidget> {
  List<FilmBean> films;
  double itemWidth = 100;

  Widget _getItem(FilmBean bean) {
    Widget _image = ImageUtils.getImageFromNetwork(bean.image, itemWidth, 140, radius: 4);
    Widget _rating = ImageUtils.getRating(bean.rating, margin: EdgeInsets.only(top: 4));
    Widget _name = Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(bean.name, style: TextStyle(fontWeight: FontWeight.bold), maxLines: 1,),
    );

    return Container(
      width: itemWidth,
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _image,
          _name,
          _rating
        ],
      ),
    );
  }

  Widget _getList() {
    if (films == null)
      return Container();
    return Container(
      margin: EdgeInsets.only(left: 4),
      child: Wrap(
        runSpacing: 14,
        children: films.map((item){
          return _getItem(item);
        }).toList(),
        spacing: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _title = ImageUtils.getTitle('豆瓣热门', count: 500, margin: EdgeInsets.only(left: 14, right: 14, bottom: 20));
    Widget _list = _getList();

    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_title, _list],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    HttpUtils.getHttp(MovieUrlConfig.getHotMovies).then((val) {
      setState(() {
        films = FilmBean.getFilms(val['subjects']).sublist(0, 6);
      });
    });
  }
}
