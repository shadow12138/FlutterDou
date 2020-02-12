import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/movie_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class FilmRecommendWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilmRecommendState();
  }
}

class FilmRecommendState extends State<FilmRecommendWidget> {
  List<MovieBean> movies;
  double imageHeight = 120;

  Widget _getTag(String tag) {
    return Container(
      decoration: BoxDecoration(
          color: ImageUtils.fromHex('#F8EEE4'),
          borderRadius: BorderRadius.all(Radius.circular(100))),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: EdgeInsets.only(right: 10),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text('$tag ',
              style: TextStyle(color: ImageUtils.fromHex('#736852'), fontSize: 11)),
          Icon(Icons.arrow_forward_ios, size: 10, color: ImageUtils.fromHex('#847969'),)
        ],
      )
    );
  }

  Widget _getItem(MovieBean bean) {
    Widget _images = Container(
      child: Row(
        children: <Widget>[
          ImageUtils.getImageFromNetwork(bean.image, 100, imageHeight,
              radius: 4),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              height: imageHeight,
              child: Swiper(
                itemBuilder: (context, index) {
                  return ImageUtils.getImageFromNetwork(
                      bean.images[index], 80, imageHeight,
                      radius: 4);
                },
                itemCount: bean.images.length,
                pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        activeColor: Colors.white,
                        color: Color.fromARGB(88, 255, 255, 255),
                        size: 4,
                        activeSize: 4,
                        space: 2),
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.all(10)),
              ),
            ),
          )
        ],
      ),
    );
    Widget _title = Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          Text(
            bean.name,
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          Text(
            '(${bean.year})',
            style:
                TextStyle(color: ImageUtils.fromHex('#999999'), fontSize: 20),
          ),
        ],
      ),
    );
    Widget _rating = ImageUtils.getRating(bean.rating, margin: EdgeInsets.only(top: 4));
    Widget _comment = Container(
      margin: EdgeInsets.only(top: 8),
      child: Text(
        bean.comment,
        style: TextStyle(color: ImageUtils.fromHex('#999999')),
      ),
    );
    Widget _tags = Container(
      margin: EdgeInsets.only(top: 10),
      child: Wrap(
        runSpacing: 6,
        children: bean.tags.map((item) {
          return _getTag(item);
        }).toList(),
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_images, _title, _rating, _comment, _tags],
      ),
    );
  }

  Widget _getList() {
    if (movies == null) return Container();
    return Column(
      children: movies.map((item){
        return _getItem(item);
      }).toList(),
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
        children: <Widget>[_title, _list],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getHttp(MovieUrlConfig.getRecommend).then((val) {
      setState(() {
        movies = MovieBean.getList(val);
      });
    });
  }
}
