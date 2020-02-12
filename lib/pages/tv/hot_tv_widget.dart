
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/file_bean.dart';
import 'package:flutter_app/model/hot_tv_series_bean.dart';
import 'package:flutter_app/model/tv_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:flutter_app/utils/size_utils.dart';
import 'package:rating_bar/rating_bar.dart';

class HotTvWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotTvState();
  }
}

class HotTvState extends State<HotTvWidget> {
  List<SeriesBean> seriesList;
  double itemWidth = 100;
  int currentPage = 0;

  Widget _getItem(TvBean bean) {
    Widget _image = ImageUtils.getImageFromNetwork(bean.image, itemWidth, 140, radius: 4);
    Widget _name = Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(
        bean.name,
        style:
        TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
    Widget _rating = ImageUtils.getRating(bean.rating, margin: EdgeInsets.only(top: 4));

    return Container(
      width: itemWidth,
      margin: EdgeInsets.only(left: 14),
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
    if(seriesList == null)
      return Container();
    return Container(
      margin: EdgeInsets.only(top: 14),
      child: Wrap(
        children: seriesList[currentPage].tvList.map((item){
          return _getItem(item);
        }).toList(),
        spacing: 3,
        runSpacing: 14,
      ),
    );
  }

  Widget _getTab(){
    if(seriesList == null)
      return Container();

    List<Widget> children = [];
    for(int i = 0; i < seriesList.length; i++){
      String title = seriesList[i].title;
      bool selected = i == currentPage;
      Color textColor = selected ? Colors.black : Colors.black54;
      FontWeight fontWeight = selected ? FontWeight.bold : FontWeight.normal;
      children.add(InkWell(
        onTap: (){
          setState(() {
            currentPage = i;
          });
        },

        child: Container(
          margin: EdgeInsets.only(right: 20),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: selected ? Colors.black : Colors.transparent, width: 2))),
          child: Text(title, style: TextStyle(color: textColor, fontWeight: fontWeight),),
        ),
      ));
    }

    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: ImageUtils.getDividerColor(), width: 0.5))),
      margin: EdgeInsets.only(left: 14, right: 14, top: 4),
      child: Row(children: children,),
    );
  }

  @override
  Widget build(BuildContext context) {

    int count = seriesList == null ? 0 : seriesList[currentPage].count;
    Widget _title = ImageUtils.getTitle('热播新剧', count: count, margin: EdgeInsets.symmetric(horizontal: 14));

    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_title, _getTab(), _getList()],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    HttpUtils.getTvHttp(TvUrlConfig.getHotTvs).then((val) {
      setState(() {
        seriesList = SeriesBean.getList(val);
      });
    });
  }
}
