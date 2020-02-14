import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application.dart';
import 'package:flutter_app/pages/film/detail/movie_detail_page.dart';
import 'package:flutter_app/route/config.dart';
import 'package:provider/provider.dart';

import 'index_page.dart';

void main() {
  runApp(MyApp());
//  runApp(MovieDetailPage(''));
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final router = Router();
    RouteConfig.defineRoutes(router);
    MyApplication.router = router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageNotifier()),
      ],
      child: Consumer<PageNotifier>(
        builder: (context, counter, _) {
          return MaterialApp(
            onGenerateRoute: MyApplication.router.generator,
            home: IndexPage()
          );
        },
      ),
    );
  }
}




