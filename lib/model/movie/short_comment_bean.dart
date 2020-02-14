import 'package:flutter_app/model/movie/user_bean.dart';

class ShortCommentBean {
  int rating;
  int usefulCount;
  UserBean author;
  String subjectId;
  String content;
  String createdAt;
  String id;

  ShortCommentBean(
      {this.rating,
        this.usefulCount,
        this.author,
        this.subjectId,
        this.content,
        this.createdAt,
        this.id});

  ShortCommentBean.fromJson(Map<String, dynamic> json) {
    rating = json['rating']['value'].round();
    usefulCount = json['useful_count'];
    author = UserBean.fromJson(json['author']);
    subjectId = json['subject_id'];
    content = json['content'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  static List<ShortCommentBean> getList(List<dynamic> subjects){
    List<ShortCommentBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(ShortCommentBean.fromJson(subject));
    }
    return beans;
  }

}



