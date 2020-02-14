import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/tv/tv_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class TvRecommendWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TvRecommendState();
  }
}

class TvRecommendState extends State<TvRecommendWidget> {
  List<TvBean> recommends;

  Widget _getItem(TvBean bean) {

    Widget _left = ImageUtils.getImageFromNetwork(bean.image, 100, 120, radius: 4);

    Widget _name = Text(bean.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),);
    Widget _rating = ImageUtils.getRating(bean.rating, margin: EdgeInsets.only(top: 4));
    Widget _desc = Container(margin: EdgeInsets.only(top: 4), child: Text(bean.desc, style: TextStyle(color: ImageUtils.getTextColor2(), ),),);
    Widget _tag = Container(
      width: 1000,
      margin: EdgeInsets.only(top: 14),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: ImageUtils.getBackgroundColor()),
      padding: EdgeInsets.all(10),
      child: Text('你可能感兴趣', style: TextStyle(color: ImageUtils.getTextColor2()),),
    );
    Widget _right = Expanded(child: Container(
      margin: EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _name, _rating, _desc, _tag
        ],
      ),
    ),);


    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5, color: ImageUtils.getDividerColor()))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _left, _right
        ],
      ),
    );
  }

  Widget _getList() {
    if (recommends == null) return Container();
    return Container(
      child: Column(
        children: recommends.map((item) {
          return _getItem(item);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget _title = ImageUtils.getTitle('为你推荐');
    Widget _list = _getList();

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: <Widget>[_title, _list],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getTvHttp(TvUrlConfig.getRecommend).then((val) {
      setState(() {
        recommends = TvBean.getList(val);
      });
    });
  }
}
