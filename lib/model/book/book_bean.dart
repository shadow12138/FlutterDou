class BookBean {
  String name;
  int collectCount;
  String comment;
  String image;
  String author;
  String country;
  String desc;
  String tag;
  double rating;

  static BookBean getItem(Map<String, dynamic> subject) {
    BookBean bean = BookBean();
    bean.name = subject['name'];
    bean.collectCount = subject['collect_count'];
    bean.comment = subject['comment'];
    bean.country = subject['country'];
    bean.author = subject['author'];
    bean.image = subject['image'];
    bean.rating = subject['rating'];
    bean.desc = subject['desc'];
    bean.tag = subject['tag'];

    return bean;
  }

  static List<BookBean> getList(List<dynamic> subjects) {
    List<BookBean> beans = [];
    for (Map<String, dynamic> subject in subjects) {
      beans.add(getItem(subject));
    }
    return beans;
  }

  @override
  String toString() {
    return 'name: $name, author: $author';
  }
}
