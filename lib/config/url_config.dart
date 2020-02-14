

class UrlConfig{
  static final host = 'http://api.douban.com/v2/';
  static final  apiKey = '0df993c66c0c636e29ecbb5344252a4a';
}

class MovieUrlConfig{
  static final movieHost = UrlConfig.host + 'movie/';

  static final getHotMovies = movieHost + 'in_theaters';

  static final getUsBox = movieHost + 'us_box';

  static final getWeekly = movieHost + 'weekly';

  static final getNew = movieHost + 'new_movies';

  static final getComingSoon = movieHost + 'coming_soon';

  static final getRecommend = movieHost + 'recommends';

  static final getDetail = movieHost + 'detail';

}

class TvUrlConfig{
  static final tvHost = UrlConfig.host + 'tv/';

  static final getHotTvs = tvHost + 'hot_series';

  static final getHotEntertainments = tvHost + 'hot_entertainments';

  static final getRanks = tvHost + 'ranks';

  static final getRecommend = tvHost + 'recommneds';
}

class BookUrlConfig{
  static final bookHost = UrlConfig.host + 'book/';

  static final getNewBooks = bookHost + 'new_books';

  static final getRanks = bookHost + 'ranks';
  
  static final getLists = bookHost + 'lists';

  static final getRecommend = bookHost + 'recommends';
}

class NovelUrlConfig{
  static final novelHost = UrlConfig.host + "novel/";

  static final getRecommend = novelHost + 'recommends';

  static final getHot = novelHost + 'hot';

  static final getRank = novelHost + 'ranks';

  static final getTopics = novelHost + 'topics';

  static final getClassic = novelHost + 'classics';
}

class MusicUrlConfig{
  static final musicHost = UrlConfig.host + 'music/';

  static final getHot = musicHost + 'hot';

  static final getRank = musicHost + 'ranks';

  static final getCategory = musicHost + 'categories';

  static final getRecommend = musicHost + 'recommends';
}