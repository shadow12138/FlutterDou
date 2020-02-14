import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/music/music_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class MusicRecommendWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MusicRecommendState();
  }
}

class MusicRecommendState extends State<MusicRecommendWidget> {
  List<MusicBean> musics;

  Widget _getTitle() {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        '为你推荐',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }

  Widget _getList() {
    if (musics == null) return Container();

    List<Widget> children = [];
    for(int i = 0; i < musics.length; i++){
      children.add(_getItem(musics[i], i == musics.length - 1));
    }

    return Column(
      children: children,
    );
  }

  Widget _getItem(MusicBean bean, bool isLast) {
    Widget _left = ImageUtils.getImageFromNetwork(bean.image, 80, 80, radius: 4);
    Widget _name = Container(
        child: Text(
      bean.name,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    ));
    Widget _rating = ImageUtils.getRating(bean.rating, margin: EdgeInsets.only(top: 6));
    Widget _desc = Container(
      child: Text(
        bean.desc,
        style: TextStyle(color: ImageUtils.fromHex('#747271'), fontSize: 13),
      ),
      margin: EdgeInsets.only(top: 6),
    );
    Widget _icon = Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: <Widget>[
          Image.asset('assets/ic_info_wish.png', width: 20, height: 20,),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text('想听', style: TextStyle(color: ImageUtils.fromHex('#E4AB72'), fontSize: 11),),
          )
        ],
      ),
    );
    Widget _bottom = Container(
      margin: EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
          color: ImageUtils.fromHex('#F7F7F7'),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '你可能感兴趣',
              style: TextStyle(color: ImageUtils.fromHex('#A2A2A2')),
            ),
          )
        ],
      ),
    );
    Widget _top = Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[_name, _rating, _desc],
            ),
          ),
          _icon
        ],
      ),
    );
    Widget _right = Expanded(
        child: Container(
      margin: EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_top, _bottom],
      ),
    ));

    Color borderColor = isLast ? Colors.transparent : ImageUtils.fromHex('#E9E9E9');
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderColor, width: 0.5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_left, _right],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      margin: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[_getTitle(), _getList()],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getMusicHttp(MusicUrlConfig.getRecommend).then((val) {
      setState(() {
        musics = MusicBean.getList(val);
      });
    });
  }
}
