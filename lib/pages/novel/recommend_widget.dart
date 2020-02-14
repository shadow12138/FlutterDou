import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/novel/novel_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:flutter_app/utils/size_utils.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class RecommendWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RecommendState();
  }
}

class RecommendState extends State<RecommendWidget> {
  double itemWidth = SizeUtils.getScreenWidth();
  double itemHeight = 140;
  List<NovelBean> novels;

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            '重磅推荐',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, bottom: 1),
            child: Text(
              '豆瓣阅读优质原创小说',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _getItem(NovelBean bean){
    Widget _left = ImageUtils.getImageFromNetwork(bean.image, 90, 110, radius: 4);

    Widget _name = Container(
      child: Text(bean.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
    );
    Widget _author = Container(
      margin: EdgeInsets.only(top: 6),
      child: Text('作者：${bean.author}', style: TextStyle(color: ImageUtils.fromHex('#868288'), fontSize: 13),),
    );
    Widget _rating = ImageUtils.getRating(bean.rating, margin: EdgeInsets.only(top: 6));
    Widget _comment = Container(
        margin: EdgeInsets.only(top: 14),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: ImageUtils.fromHex('#F7F7F7')),
        child: Text(bean.comment, style: TextStyle(fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis,),
      );
    Widget _right = Expanded(
      child: Container(

        margin: EdgeInsets.only(left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _name, _author, _rating, _comment
          ],
        ),
      ),
    );

    return Container(
      height: itemHeight,
      margin: EdgeInsets.only(right: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _left, _right
        ],
      ),
    );
  }

  Widget _getPage(List<NovelBean> beans){
    return Container(
      child: Column(
        children: beans.map((item){
          return _getItem(item);
        }).toList(),
      ),
    );
  }

  Widget _getPages(){
    if(novels == null)
      return Container();

    // 每页显示两个item
    List<List<NovelBean>> pages = [];
    for (int i = 0; i < novels.length; i += 2) {
      List<NovelBean> page = [novels[i]];
      if (i + 1 < novels.length) page.add(novels[i + 1]);
      pages.add(page);
    }

    return Container(
      height: itemHeight * 2,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return _getPage(pages[index]);
        },
        itemCount: pages.length,
        viewportFraction: 0.92,
        loop: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_getTitle(), _getPages()],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    HttpUtils.getNovelHttp(NovelUrlConfig.getRecommend).then((val) {
      setState(() {
        novels = NovelBean.getList(val);
      });
    });
  }
}
