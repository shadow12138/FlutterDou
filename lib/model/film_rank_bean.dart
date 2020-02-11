import 'package:flutter/material.dart';
import 'package:flutter_app/model/file_bean.dart';

class FilmRankBean{

  Color mainColor;
  String image;
  String title;
  List<FilmBean> movies;

  FilmRankBean(this.movies, this.title, this.image, this.mainColor);

}