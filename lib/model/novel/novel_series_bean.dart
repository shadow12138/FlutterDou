import 'package:flutter_app/model/novel/novel_bean.dart';

class NovelSeriesBean{
  String title;
  int count;
  List<NovelBean> novelList;

  static getItem(Map<String, dynamic> subject){
    String title = subject['title'];
    int count = subject['count'];
    List<NovelBean> novelList = NovelBean.getList(subject['subjects']);

    NovelSeriesBean bean = NovelSeriesBean();
    bean.title = title;
    bean.novelList = novelList;
    bean.count = count;
    return bean;
  }

  static getList(List<dynamic> subjects){
    List<NovelSeriesBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(getItem(subject));
    }
    return beans;
  }
}