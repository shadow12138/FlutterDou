import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/pages/film/detail/movie_detail_page.dart';

class RouteHandler{

  static Handler movieDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return MovieDetailPage(params["id"][0]);
  });

}