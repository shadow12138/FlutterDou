class TvBean {
  double rating;
  String name;
  String image;
  int year;
  String desc;

  static TvBean getItem(Map<String, dynamic> subject) {
    double rating = subject['rating'];
    String name = subject['name'];
    String image = subject['image'];
    int year = subject['year'];
    String desc = subject['desc'];

    TvBean bean = TvBean();
    bean.rating = rating;
    bean.name = name;
    bean.image = image;
    bean.year = year;
    bean.desc = desc;

    return bean;
  }

  static List<TvBean> getList(List<dynamic> subjects) {
    List<TvBean> items = [];

    for (Map<String, dynamic> subject in subjects) {
      items.add(getItem(subject));
    }

    return items;
  }

  @override
  String toString() {
    return "name:$name, rating:$rating";
  }
}
