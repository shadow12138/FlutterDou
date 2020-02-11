
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
  double itemWidth = 104;

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 14, right: 14),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '豆瓣热门',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Text('全部 500', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
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
              margin: EdgeInsets.only(top: 4),
              child: Row(
                children: <Widget>[
                  RatingBar.readOnly(
                    size: 12,
                    filledColor: Color.fromARGB(255, 240, 173, 70),
                    emptyColor: Color.fromARGB(255, 202, 202, 202),
                    initialRating: bean.rating / 2,
                    isHalfAllowed: true,
                    halfFilledIcon: Icons.star_half,
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 2, top: 1),
                    child: Text(
                      '${bean.rating}',
                      style: TextStyle(color: Colors.black45, fontSize: 10),
                    ),
                  )
                ],
              ))
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
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[_getTitle(), _getList()],
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
