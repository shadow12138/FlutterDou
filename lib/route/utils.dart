import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

import '../application.dart';

class RouterUtils{

  static void navigateToMovieDetail(BuildContext context, String id){
    MyApplication.router.navigateTo(context, '/movie/detail?id=$id', transition: TransitionType.inFromRight);
  }

}