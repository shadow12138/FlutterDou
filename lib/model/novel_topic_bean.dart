class NovelTopicBean{

  String title;
  int collectCount;
  int count;
  List<String> images;

  static NovelTopicBean getItem(Map<String, dynamic> subject){
    String title = subject['title'];
    int collectCount = subject['collect_count'];
    int count = subject['count'];
    List<String> images = [];
    for(String image in subject['images'])
      images.add(image);

    NovelTopicBean bean = NovelTopicBean();
    bean.title = title;
    bean.collectCount = collectCount;
    bean.count = count;
    bean.images = images;

    return bean;
  }

  static List<NovelTopicBean> getList(List<dynamic> subjects){
    List<NovelTopicBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(getItem(subject));
    }
    return beans;
  }

}