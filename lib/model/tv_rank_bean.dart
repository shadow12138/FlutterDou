import 'dart:ui';

import 'package:flutter_app/model/tv_bean.dart';
import 'package:flutter_app/utils/image_utils.dart';

class TvRankBean{
  String title;
  List<TvBean> tvList;
  String image;
  Color mainColor;

  static TvRankBean getItem(Map<String, dynamic> subject){
    String title = subject['title'];
    String color = subject['color'];
    String image = subject['image'];
    List<TvBean> tvList = TvBean.getList(subject['subjects']);

    TvRankBean bean = TvRankBean();
    bean.title = title;
    bean.tvList = tvList;
    bean.image = image;
    bean.mainColor = ImageUtils.fromHex(color);
    return bean;
  }

  static List<TvRankBean> getList(List<dynamic> subjects){
    List<TvRankBean> items = [];
    for(Map<String, dynamic> subject in subjects){
      items.add(getItem(subject));
    }
    return items;
  }

  @override
  String toString() {
    return this.tvList.toString();
  }
}