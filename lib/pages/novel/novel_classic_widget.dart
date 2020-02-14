import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/novel/novel_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class NovelClassicWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NovelClassicState();
  }
}

class NovelClassicState extends State<NovelClassicWidget> {
  List<NovelBean> novels;

  Widget _getTitle() {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: 14, top: 20),
      child: Text(
        '经典高分',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _getList() {
    if (novels == null) return Container();
    return Column(
      children: novels.map((item) {
        return _getItem(item);
      }).toList(),
    );
  }

  Widget _getItem(NovelBean bean) {
    Widget _left = ImageUtils.getImageFromNetwork(bean.image, 80, 120, radius: 4);

    Widget _name = Container(
      child: Text(
        bean.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
    Widget _author = Container(
      margin: EdgeInsets.only(top: 2),
      child: Text(
        '作者：${bean.author}',
        style: TextStyle(color: ImageUtils.fromHex('#343434'), fontSize: 13),
      ),
    );
    Widget _rating = ImageUtils.getRating(bean.rating, margin: EdgeInsets.only(top: 10));
    Widget _type = Container(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 4),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            border: Border.all(color: ImageUtils.fromHex('#EDEDED'))),
        child: Text(
          '${bean.type}小说',
          style: TextStyle(color: ImageUtils.fromHex('#CECECE'), fontSize: 10),
        ),
      ),
    );
    Widget _comment = Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        bean.comment,
        style: TextStyle(fontSize: 13, color: ImageUtils.fromHex('#777777')),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
    Widget _right = Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _name, _author, _rating, _comment, _type
          ],
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14),
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom:
              BorderSide(color: ImageUtils.fromHex('#E7E7E7'), width: 0.5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_left, _right],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_getTitle(), _getList()],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getNovelHttp(NovelUrlConfig.getClassic).then((val) {
      setState(() {
        novels = NovelBean.getList(val);
      });
    });
  }
}
