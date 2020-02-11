import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/novel/hot_novel_widget.dart';
import 'package:flutter_app/pages/novel/novel_classic_widget.dart';
import 'package:flutter_app/pages/novel/novel_rank_widget.dart';
import 'package:flutter_app/pages/novel/novel_topic_widget.dart';
import 'package:flutter_app/pages/novel/recommend_widget.dart';

class NovelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            RecommendWidget(),
            HotNovelWidget(),
            NovelRankWidget(),
            NovelTopicWidget(),
            NovelClassicWidget()
          ],
        ),
      ),
    );
  }
}
