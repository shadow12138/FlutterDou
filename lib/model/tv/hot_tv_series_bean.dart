import 'package:flutter_app/model/tv/tv_bean.dart';

class SeriesBean{
  String title;
  int count;
  List<TvBean> tvList;

  static getItem(Map<String, dynamic> subject){
    String title = subject['title'];
    int count = subject['count'];
    List<TvBean> tvList = TvBean.getList(subject['subjects']);

    SeriesBean bean = SeriesBean();
    bean.title = title;
    bean.tvList = tvList;
    bean.count = count;
    return bean;
  }

  static getList(List<dynamic> subjects){
    List<SeriesBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(getItem(subject));
    }
    return beans;
  }
}