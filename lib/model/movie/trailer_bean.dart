class TrailerBean {
  String medium;
  String title;
  String subjectId;
  String alt;
  String small;
  String resourceUrl;
  String id;

  TrailerBean(
      {this.medium,
      this.title,
      this.subjectId,
      this.alt,
      this.small,
      this.resourceUrl,
      this.id});

  TrailerBean.fromJson(Map<String, dynamic> json) {
    medium = json['medium'];
    title = json['title'];
    subjectId = json['subject_id'];
    alt = json['alt'];
    small = json['small'];
    resourceUrl = json['resource_url'];
    id = json['id'];
  }

  static List<TrailerBean> getList(List<dynamic> subjects){
    List<TrailerBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(TrailerBean.fromJson(subject));
    }
    return beans;
  }
}
