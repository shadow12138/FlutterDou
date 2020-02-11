import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/music/categorical_music_widget.dart';
import 'package:flutter_app/pages/music/hot_music_widget.dart';
import 'package:flutter_app/pages/music/music_rank_widget.dart';
import 'package:flutter_app/pages/music/music_recommend_widget.dart';

class MusicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          children: <Widget>[
            HotMusicWidget(),
            MusicRankWidget(),
            CategoricalMusicWidget(),
            MusicRecommendWidget()
          ],
        ),
      ),
    );
  }
}
