import 'package:fluro/fluro.dart';
import 'package:flutter_app/route/hander.dart';

class RouteConfig{
  static defineRoutes(Router router) {
    router.define("/movie/detail", handler: RouteHandler.movieDetailHandler);

    // it is also possible to define the route transition to use
    // router.define("users/:id", handler: usersHandler, transitionType: TransitionType.inFromLeft);
  }
}