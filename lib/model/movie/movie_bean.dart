class MovieBean {
  String name;
  int year;
  double rating;
  String comment;
  String image;
  List<String> tags;
  List<String> images;
  String id;

  static MovieBean getItem(Map<String, dynamic> subject) {
    MovieBean bean = MovieBean();
    bean.name = subject['name'];
    bean.rating = subject['rating'];
    bean.comment = subject['comment'];
    bean.image = subject['image'];
    bean.year = subject['year'];
    bean.id = subject['id'];

    if (subject['tags'] != null) {
      List<String> tags = [];
      for (String tag in subject['tags']) tags.add(tag);
      bean.tags = tags;
    }

    if (subject['images'] != null) {
      List<String> images = [];
      for (String image in subject['images']) images.add(image);
      bean.images = images;
    }

    return bean;
  }

  static List<MovieBean> getList(List<dynamic> subjects) {
    return subjects.map((item) {
      return getItem(item);
    }).toList();
  }
}
