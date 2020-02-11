class FilmBean {
  String image;
  String name;
  double rating;
  int collectCount;
  String pubDate;

  FilmBean({this.image, this.name, this.rating});

  static FilmBean getFilm(Map<String, dynamic> subject) {
    double rating = 0;
    if (subject['rating'] != null)
      rating = subject['rating']['average'].toDouble();

    var name = subject['title'];
    var image = subject['images']['small'];

    FilmBean bean = FilmBean(rating: rating, image: image, name: name);
    bean.collectCount = subject['collect_count'];
    String pubDate = subject['mainland_pubdate'];
    if(pubDate.split('-').length == 3){
      List<String> date = pubDate.split('-');
      pubDate = date[1] + '月' + date[2] + '日';
    }
    bean.pubDate = pubDate;

    return bean;
  }

  static List<FilmBean> getFilms(List<dynamic> subjects) {
    List<FilmBean> films = [];
    for (Map<String, dynamic> subject in subjects) {
      films.add(getFilm(subject));
    }
    return films;
  }

  @override
  String toString() {
    return 'name:$name, rating:$rating, image:$image';
  }
}
