
import 'images_bean.dart';

class StaffBean {
  ImagesBean avatars;
  String nameEn;
  String name;
  String alt;
  String id;
  String type;

  StaffBean({this.avatars, this.nameEn, this.name, this.alt, this.id});

  StaffBean.fromJson(Map<String, dynamic> json, String t) {
    avatars = ImagesBean.fromJson(json['avatars']);
    nameEn = json['name_en'];
    name = json['name'];
    alt = json['alt'];
    id = json['id'];
    type = t;
  }

  static List<StaffBean> getList(List<dynamic> subjects, String t){
    List<StaffBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(StaffBean.fromJson(subject, t));
    }
    return beans;
  }
}

