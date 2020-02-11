import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index_page.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageNotifier()),
      ],
      child: Consumer<PageNotifier>(
        builder: (context, counter, _) {
          return MaterialApp(
            home: IndexPage()
          );
        },
      ),
    );
  }
}




