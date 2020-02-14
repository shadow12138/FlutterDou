import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/music/music_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class HotMusicWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HotMusicState();
  }
}

class HotMusicState extends State<HotMusicWidget> {
  List<MusicBean> musics;
  double itemWidth = 100;

  Widget _getTitle() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 14),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '热门单曲榜',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(
                  '全部 30 ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 12,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _getItem(MusicBean bean) {
    Widget _coverImage =
        ImageUtils.getImageFromNetwork(bean.image, itemWidth, itemWidth, radius: 4);
    Widget _name = Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(
        bean.name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
    Widget _artist = Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(bean.artist, style: TextStyle(color: ImageUtils.fromHex('#848484'), fontSize: 12),),
    );
    Widget _rating = ImageUtils.getRating(bean.rating, margin: EdgeInsets.only(top: 4));
    
    return Container(
      width: itemWidth,
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_coverImage, _name, _artist, _rating],
      ),
    );
  }

  Widget _getList() {
    if (musics == null) return Container();
    return Container(
      margin: EdgeInsets.only(left: 4),
      child: Wrap(
        children: musics.map((item){
          return _getItem(item);
        }).toList(),
        spacing: 3,
        runSpacing: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_getTitle(), _getList()],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getMusicHttp(MusicUrlConfig.getHot).then((val) {
      setState(() {
        musics = MusicBean.getList(val);
      });
    });
  }
}
