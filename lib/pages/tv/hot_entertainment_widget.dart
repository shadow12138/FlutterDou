
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

class HotEntertainmentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotEntertainmentState();
  }
}

class HotEntertainmentState extends State<HotEntertainmentWidget> {
  List<SeriesBean> seriesList;
  double itemWidth = 104;
  int currentPage = 0;

  Widget _getTitle() {
    String count = seriesList == null ? "": seriesList[currentPage].count.toString();
    return Container(
      margin: EdgeInsets.only(bottom: 4, left: 14, right: 14),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '热播综艺',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Text('全部 $count', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
          Container(
            margin: EdgeInsets.only(left: 2, top: 2),
            child: Icon(Icons.arrow_forward_ios, size: 12,),
          )
        ],
      ),
    );
  }

  Widget _getItem(TvBean bean) {
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
              overflow: TextOverflow.ellipsis,
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
    if (seriesList != null) {
      return Container(
        margin: EdgeInsets.only(left: 4),
        child: Wrap(
          children: seriesList[currentPage].tvList.map((item){
            return _getItem(item);
          }).toList(),
          spacing: 3,
        ),
      );
    }
    return Container();
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
          padding: EdgeInsets.only(left: 10, right: 10),

          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: selected ? Colors.black : Colors.transparent, width: 2))),
            child: Text(title, style: TextStyle(color: textColor, fontWeight: fontWeight),),
          ),
        ),
      ));
    }

    return Container(
      margin: EdgeInsets.only(left: 6),
      child: Row(children: children,),
    );
  }

  Widget _getDivider(){
    return Container(

      color: Color.fromARGB(255, 230, 230, 230),
      height: 0.5,
      width: SizeUtils.getScreenWidth(),
      margin: EdgeInsets.only(left: 14, right: 14, bottom: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[_getTitle(), _getTab(), _getDivider(), _getList()],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    HttpUtils.getTvHttp(TvUrlConfig.getHotEntertainments).then((val) {
      setState(() {
        seriesList = SeriesBean.getList(val);
      });
    });
  }
}
