class NovelBean {
  String name;
  String author;
  double rating;
  String image;
  String comment;
  String type;

  static NovelBean getItem(Map<String, dynamic> subject) {
    String name = subject['name'];
    String author = subject['author'];
    String image = subject['image'];
    String comment = subject['comment'];
    double rating = subject['rating'];
    String type = subject['type'];

    NovelBean bean = NovelBean();
    bean.name = name;
    bean.image = image;
    bean.author = author;
    bean.comment = comment;
    bean.rating = rating;
    bean.type = type;

    return bean;
  }

  static List<NovelBean> getList(List<dynamic> subjects) {
    List<NovelBean> list = [];
    for (Map<String, dynamic> subject in subjects) {
      list.add(getItem(subject));
    }
    return list;
  }

  @override
  String toString() {
    return 'name: $name, author: $author}';
  }
}
