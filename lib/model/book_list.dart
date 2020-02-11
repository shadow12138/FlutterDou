class BookListBean{

  String title;
  String author;
  String avatar;
  int collectCount;
  int count;
  List<String> images;

  static BookListBean getItem(Map<String, dynamic> subject){
    String title = subject['title'];
    String author = subject['author'];
    String avatar = subject['avatar'];
    int collectCount = subject['collect_count'];
    int count = subject['count'];
    List<String> images = [];
    for(String image in subject['images'])
      images.add(image);

    BookListBean bean = BookListBean();
    bean.title = title;
    bean.author = author;
    bean.avatar = avatar;
    bean.collectCount = collectCount;
    bean.count = count;
    bean.images = images;

    return bean;
  }

  static List<BookListBean> getList(List<dynamic> subjects){
    List<BookListBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(getItem(subject));
    }
    return beans;
  }

}