import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/music/music_bean.dart';
import 'package:flutter_app/model/music/music_rank_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class CategoricalMusicWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CategoricalMusicState();
  }
}

class CategoricalMusicState extends State<CategoricalMusicWidget>{
  List<MusicRankBean> categories;
  double itemWidth = 100;

  Widget _getTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '分类浏览',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(
                  '全部 ',
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

  Widget _getList(){
    if(categories == null)
      return Container();
    return Column(
      children: categories.map((item){
        return _getRow(item);
      }).toList(),
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

  Widget _getRow(MusicRankBean bean){
    Widget _title = Container(
      margin: EdgeInsets.only(left: 14, bottom: 10, top: 10),
      child: Row(
        children: <Widget>[
          Container(child: Text('${bean.title} ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),), margin: EdgeInsets.only(bottom: 2),),
          Icon(Icons.arrow_forward_ios, size: 12,)
        ],
      ),

    );

    Widget _content = Container(
      margin: EdgeInsets.only(left: 4),
      child: Wrap(
        children: bean.musics.map((item){
          return _getItem(item);
        }).toList(),
        spacing: 3,
      ),
    );

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _title,
          _content
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: <Widget>[
          _getTitle(), _getList()
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getMusicHttp(MusicUrlConfig.getCategory).then((val){
      setState(() {
        categories = MusicRankBean.getList(val);
      });
    });
  }
}