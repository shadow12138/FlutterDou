class PhotoBean {
  String thumb;
  String image;
  String cover;
  String alt;
  String id;
  String icon;

  PhotoBean({this.thumb, this.image, this.cover, this.alt, this.id, this.icon});

  PhotoBean.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    image = json['image'];
    cover = json['cover'];
    alt = json['alt'];
    id = json['id'];
    icon = json['icon'];
  }

  static List<PhotoBean> getList(List<dynamic> subjects){
    List<PhotoBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(PhotoBean.fromJson(subject));
    }
    return beans;
  }
}