import 'package:flutter_app/model/movie/director_bean.dart';
import 'package:flutter_app/model/movie/photo_bean.dart';
import 'package:flutter_app/model/movie/rating_bean.dart';
import 'package:flutter_app/model/movie/short_comment_bean.dart';
import 'package:flutter_app/model/movie/trailer_bean.dart';
import 'images_bean.dart';

class MovieDetailBean {
  String title;
  String year;
  ImagesBean images;
  List<String> countries;
  List<String> genres;
  List<String> pubdates;
  List<String> durations;
  RatingBean rating;
  int ratingsCount;
  int collectCount;
  int wishCount;
  List<String> tags;
  String summary;
  List<StaffBean> directors;
  List<StaffBean> casts;
  List<TrailerBean> trailers;
  List<PhotoBean> photos;
  int commentCounts;
  List<ShortCommentBean> shortComments;

  MovieDetailBean(
      {this.title,
        this.year,
        this.images,
        this.countries,
        this.genres,
        this.pubdates,
        this.durations});

  MovieDetailBean.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    year = json['year'];
    images = ImagesBean.fromJson(json['images']);
    countries = json['countries'].cast<String>();
    directors = StaffBean.getList(json['directors'], '导演');
    casts = StaffBean.getList(json['casts'], '演员');
    trailers = TrailerBean.getList(json['trailers']);
    shortComments = ShortCommentBean.getList(json['popular_comments']);
    photos = PhotoBean.getList(json['photos']);
    tags = json['tags'].cast<String>();
    genres = json['genres'].cast<String>();
    pubdates = json['pubdates'].cast<String>();
    durations = json['durations'].cast<String>();
    rating = RatingBean.fromJson(json['rating']);
    ratingsCount = json['ratings_count'];
    wishCount = json['wish_count'];
    collectCount = json['collect_count'];
    summary = json['summary'];
    commentCounts = json['comments_count'];
  }


}



