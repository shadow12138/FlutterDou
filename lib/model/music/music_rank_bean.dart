import 'package:flutter_app/model/music/music_bean.dart';

class MusicRankBean{
  String title;
  int count;
  List<MusicBean> musics;

  static MusicRankBean getItem(Map<String, dynamic> subject){
    MusicRankBean bean = MusicRankBean();
    bean.count = subject['count'];
    bean.title = subject['title'];
    bean.musics = MusicBean.getList(subject['subjects']);

    return bean;
  }

  static List<MusicRankBean> getList(List<dynamic> subjects){
    List<MusicRankBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(getItem(subject));
    }
    return beans;
  }
}