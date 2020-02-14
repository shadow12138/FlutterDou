import 'dart:ui';

import 'package:flutter_app/model/novel/novel_bean.dart';
import 'package:flutter_app/utils/image_utils.dart';

class NovelRankBean{
  String title;
  Color mainColor;
  String image;
  List<NovelBean> novelList;

  static getItem(Map<String, dynamic> subject){
    String title = subject['title'];
    String image = subject['image'];
    String color = subject['color'];
    List<NovelBean> novelList = NovelBean.getList(subject['subjects']);

    NovelRankBean bean = NovelRankBean();
    bean.title = title;
    bean.image = image;
    bean.mainColor = ImageUtils.fromHex(color);
    bean.novelList = novelList;

    return bean;
  }

  static getList(List<dynamic> subjects){
    List<NovelRankBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(getItem(subject));
    }
    return beans;
  }
}