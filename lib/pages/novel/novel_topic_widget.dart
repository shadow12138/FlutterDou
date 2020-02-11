import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/novel_topic_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';

class NovelTopicWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NovelTopicState();
  }
}

class NovelTopicState extends State<NovelTopicWidget> {
  List<NovelTopicBean> novelTopics;
  double itemHeight = 90;

  Widget _getTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 14, right: 14, top: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '主题推荐',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          )
        ],
      ),
    );
  }

  Widget _getItem(NovelTopicBean bean, bool isLast) {
    Color borderColor = isLast ? Colors.transparent : Color.fromARGB(255, 230, 230, 230);
    return Container(
      padding: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: borderColor, width: 0.5))),
      margin: EdgeInsets.only(left: 14, right: 14, bottom: 16),
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          _getImage(bean),
          Expanded(
            child: _getDetail(bean),
          )
        ],
      ),
    );
  }
  
  Widget _getImage(NovelTopicBean bean){
    double width = 60;
    double height = 80;
    return Container(
      child: Stack(
        children: <Widget>[
          ImageUtils.getImageFromNetwork(
              bean.images[2], width - 10, height - 10,
              radius: 4, margin: EdgeInsets.only(left: 30, top: 10)),
          ImageUtils.getImageFromNetwork(
              bean.images[1], width - 5, height - 5,
              radius: 4, margin: EdgeInsets.only(left: 15, top: 5)),
          ImageUtils.getImageFromNetwork(
              bean.images[0], width, height,
              radius: 4),
        ],
      ),
    );
  }

  Widget _getLeft(NovelTopicBean bean) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            bean.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 2,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 2, top: 1),
                  child: Text(
                    '${bean.count}本 · ${bean.collectCount}人加入书架',
                    style: TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _getDetail(NovelTopicBean bean) {
    return Container(
      height: itemHeight,
      margin: EdgeInsets.only(left: 12),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: _getLeft(bean),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _getList() {
    if (novelTopics == null) return Container();

    List<Widget> children = [];
    for(int i = 0; i < novelTopics.length; i++){
      NovelTopicBean item = novelTopics[i];
      children.add(_getItem(item, i == novelTopics.length - 1));
    }

    return Container(
      child: Column(
        children: children,
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

    HttpUtils.getNovelHttp(NovelUrlConfig.getTopics).then((val) {
      setState(() {
        novelTopics = NovelTopicBean.getList(val);
      });
    });
  }
}
