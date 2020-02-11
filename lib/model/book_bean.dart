class BookBean {
  String name;
  int collectCount;
  String comment;
  String image;
  String author;
  String country;
  double rating;

  static BookBean getItem(Map<String, dynamic> subject) {
    String name = subject['name'];
    String comment = subject['comment'];
    String image = subject['image'];
    String author = subject['author'];
    String country = subject['country'];
    int collectCount = subject['collect_count'];
    double rating = subject['rating'];

    BookBean bean = BookBean();
    bean.name = name;
    bean.collectCount = collectCount;
    bean.comment = comment;
    bean.country = country;
    bean.author = author;
    bean.image = image;
    bean.rating = rating;

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
