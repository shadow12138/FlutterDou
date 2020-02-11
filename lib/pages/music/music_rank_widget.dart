import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/music_bean.dart';
import 'package:flutter_app/model/music_rank_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class MusicRankWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MusicRankState();
  }
}

class MusicRankState extends State<MusicRankWidget> {
  int currIndex = 0;
  List<MusicRankBean> ranks;
  double itemWidth = 100;

  Widget _getTitle() {
    String checkAll = ranks == null ? '全部 ' : '全部 ${ranks[currIndex].count}';
    return Container(
      padding: EdgeInsets.only(top: 20, left: 14, right: 14, bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '新碟榜',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 2),
                child: Text(
                  checkAll,
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

  Widget _getTab() {
    if(ranks == null)
      return Container();

    List<Widget> children = [];
    for(int i = 0; i < ranks.length; i++){
      bool selected = i == currIndex;
      Color borderColor = selected ? Colors.black : Colors.transparent;
      Color textColor = selected ? Colors.black : ImageUtils.fromHex('#898989');
      FontWeight fontWeight = selected ? FontWeight.bold : FontWeight.normal;
      children.add(
        InkWell(
          onTap: (){
            setState(() {
              currIndex = i;
            });
          },
          child: Container(
            margin: EdgeInsets.only(right: 20),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: borderColor, width: 2))),
            child: Text(ranks[i].title, style: TextStyle(color: textColor, fontWeight: fontWeight),),
          ),
        )
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: children,
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: ImageUtils.fromHex('#EAEAEA'), width: 0.5))),
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
    if (ranks == null) return Container();
    return Container(
      margin: EdgeInsets.only(left: 4, top: 20),
      child: Wrap(
        children: ranks[currIndex].musics.map((item){
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
      margin: EdgeInsets.only(top: 20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_getTitle(), _getTab(), _getList()],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    HttpUtils.getMusicHttp(MusicUrlConfig.getRank).then((val) {
      setState(() {
        ranks = MusicRankBean.getList(val);
      });
    });
  }
}
