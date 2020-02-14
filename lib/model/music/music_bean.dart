class MusicBean{

  String name;
  String image;
  double rating;
  String artist;
  String desc;

  static MusicBean getItem(Map<String, dynamic> subject){
    MusicBean bean = MusicBean();
    bean.name = subject['name'];
    bean.image = subject['image'];
    bean.rating = subject['rating'];
    bean.artist = subject['artist'];
    bean.desc = subject['desc'];

    return bean;
  }

  static List<MusicBean> getList(List<dynamic> subjects){
    List<MusicBean> beans = [];
    for(Map<String, dynamic> subject in subjects){
      beans.add(getItem(subject));
    }

    return beans;
  }

}