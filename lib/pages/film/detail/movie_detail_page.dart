import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/color_picker/color_thief_flutter.dart';
import 'package:flutter_app/model/movie/movie_detail_bean.dart';
import 'package:flutter_app/model/movie/director_bean.dart';
import 'package:flutter_app/model/movie/short_comment_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:rating_bar/rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  String subjectId;

  MovieDetailPage(this.subjectId);

  @override
  State<StatefulWidget> createState() {
    return StateMovieDetail(subjectId);
  }
}

class StateMovieDetail extends State<MovieDetailPage> with TickerProviderStateMixin{
  MovieDetailBean bean;
  Color mainColor = Colors.white;
  double coverImageWidth = 100;
  double coverImageHeight = 140;
  Color emptyColorDark = ImageUtils.fromHex('#E7E7E7');
  Color emptyColorLight = ImageUtils.fromHex('#F3F3F3');
  List<double> widths = [150, 154, 80, 200, 120, 280, 280, 280, 180];

  int emptySelectedLine = 0;

  String subjectId;

  StateMovieDetail(this.subjectId);

  Widget _getTitle() {
    return Container(
      padding: EdgeInsets.all(14),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/ic_arrow_back.png',
            color: Colors.white,
            width: 20,
            height: 20,
          ),
          Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  '电影',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ),
          Icon(
            Icons.more_horiz,
            color: Colors.white,
          )
        ],
      ),
    );
  }


  Widget _getEmptyContent(){
    List<Widget> lines = [];
    for(int i = 0; i < widths.length; i++){
      Color color = emptyColorLight;
      
      if(i == emptySelectedLine){
        int c = animation.value.round();
        color = Color.fromARGB(255, c, c, c);
      }
      lines.add(Container(
        color: color, height: 10, width: widths[i], margin: EdgeInsets.only(top: i == 0 ? 0 : 20),
      ));
    }

    Widget _r1 = Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), color: emptyColorDark), width: coverImageWidth, height: coverImageHeight,),
          Container(margin: EdgeInsets.only(left: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: lines.sublist(0, 3),
            ),
          )
        ],
      ),
    );
    Widget _r2 = Container(
      margin: EdgeInsets.only(left: 14, right: 14, top: 20),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
          color: emptyColorDark,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      height: 100,
      child: Row(
        children: <Widget>[
          Expanded(child: Text(''),)
        ],
      ),
    );

    Widget _r3 = Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines.sublist(3),
      ),
    );


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[_r1, _r2, _r3],
    );
  }


  Widget _getBasicInfo() {
    Widget _left =
        ImageUtils.getImageFromNetwork(bean.images.medium, coverImageWidth, coverImageHeight, radius: 4);

    Widget _name = Container(
      child: Text(
        bean.title,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
      ),
    );
    Widget _year = Container(
      margin: EdgeInsets.only(top: 4),
      child: Text(
        '(${bean.year})',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ImageUtils.fromHex('#F6FFFF'),
            fontSize: 15),
      ),
    );

    List<String> descArr = [];
    if(bean.countries.length > 0) descArr.add(bean.countries[0]);
    if(bean.genres.length > 0) {
      String curr = bean.genres[0];
      if(bean.genres.length > 1)
        curr += ' ' + bean.genres[1];
      descArr.add(curr);
    }
    if(bean.pubdates.length > 0) descArr.add('上映时间：${bean.pubdates[0]}');
    if(bean.durations.length > 0) descArr.add('片长：${bean.durations[0]}');

    String descString = '';
    for(int i = 0; i < descArr.length; i++){
      if(i != 0)
        descString += ' ';
      descString += descArr[i] + ' ';
      if(i != descArr.length - 1)
        descString += '/';
    }

    Widget _desc = Container(
      child: Text(
        descString,
        style:
            TextStyle(color: Color.fromARGB(160, 255, 255, 255), fontSize: 11),
      ),
      margin: EdgeInsets.only(top: 8),
    );
    Widget _right = Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_name, _year, _desc],
        ),
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14),
      margin: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_left, _right],
      ),
    );
  }
  Widget _getTags() {
    Widget _title = Text(
      '相关分类',
      style: TextStyle(color: Color.fromARGB(100, 255, 255, 255), fontSize: 13),
    );

    List<Widget> tags = [];
    for (int i = 0; i < bean.tags.length; i++) {
      String tag = bean.tags[i];
      tags.add(Container(
        margin: EdgeInsets.only(right: 8),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: Color.fromARGB(88, 0, 0, 0)),
        child: Row(
          children: <Widget>[
            Text(
              tag,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 4),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 10,
                color: Color.fromARGB(160, 255, 255, 255),
              ),
            )
          ],
        ),
      ));
    }

    Widget _content = Expanded(
        child: Container(
      margin: EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: tags,
          )),
    ));

    return Container(
      margin: EdgeInsets.only(top: 20, left: 14),
      child: Row(
        children: <Widget>[
          _title,
          _content,
        ],
      ),
    );
  }
  Widget _getRating() {
    Widget _title = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '豆瓣评分',
            style: TextStyle(color: Colors.white),
          ),
          Container(
            child: Text(
              'TM',
              style: TextStyle(color: Colors.white, fontSize: 6),
            ),
            margin: EdgeInsets.only(top: 2),
          )
        ],
      ),
    );
    Widget _ratingLeft = Container(
      child: Column(
        children: <Widget>[
          Text(
            '${bean.rating.average}',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          Container(
            child: RatingBar.readOnly(
              halfFilledIcon: Icons.star_half,
              filledIcon: Icons.star,
              emptyIcon: Icons.star,
              filledColor: ImageUtils.fromHex('#F3B55D'),
              emptyColor: ImageUtils.fromHex('#8895A2'),
              size: 14,
              initialRating: bean.rating.average / 2,
              isHalfAllowed: true,
            ),
            margin: EdgeInsets.only(top: 2),
          )
        ],
      ),
    );

    List<Widget> counts = [];
    int maxRatingPeople = 0;
    for (int i = bean.rating.details.length - 1; i >= 0; i--) {
      List<Widget> stars = [];
      for (int j = 0; j < i + 1; j++) {
        stars.add(Icon(
          Icons.star,
          size: 10,
          color: ImageUtils.fromHex('#929FAD'),
        ));
      }
      counts.add(Row(
        children: stars,
      ));
      maxRatingPeople = max(maxRatingPeople, bean.rating.details[i]);
    }

    double unit = maxRatingPeople / 10 + 1;

    List<Widget> peoples = [];
    for (int i = bean.rating.details.length - 1; i >= 0; i--) {
      peoples.add(Container(
        height: 10,
        width: bean.rating.details[i] / unit * 10,
        padding: EdgeInsets.symmetric(vertical: 1.5),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              color: ImageUtils.fromHex('#F2B149')),
        ),
      ));
    }
    Widget _ratingStars = Container(
      margin: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: counts,
      ),
    );
    Widget _ratingPeoples = Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: peoples,
      ),
    );
    Widget _ratingDetail = Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_ratingLeft, _ratingStars, _ratingPeoples],
      ),
    );

    Widget _ratingCount = Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(right: 14, top: 4, bottom: 4),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(33, 255, 255, 255), width: 0.5))),
      child: Text(
        '${bean.ratingsCount}人评分',
        style: TextStyle(color: Color.fromARGB(66, 255, 255, 255), fontSize: 8),
      ),
    );
    Widget _otherCount = Container(
      margin: EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            '${Utils.getPrettyNumber(bean.collectCount)}人看过  ',
            style: TextStyle(
                color: Color.fromARGB(88, 255, 255, 255), fontSize: 10),
          ),
          Text(
            '${Utils.getPrettyNumber(bean.wishCount)}人想看',
            style: TextStyle(
                color: Color.fromARGB(88, 255, 255, 255), fontSize: 10),
          )
        ],
      ),
    );
    return Container(
      margin: EdgeInsets.only(left: 14, right: 14, top: 20),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
          color: Color.fromARGB(88, 0, 0, 0),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Column(
        children: <Widget>[_title, _ratingDetail, _ratingCount, _otherCount],
      ),
    );
  }
  Widget _getIntroduction() {
    Widget _title = Text(
      '简介',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    );
    Widget _desc = Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        bean.summary,
        style: TextStyle(color: Colors.white, height: 1.5, fontSize: 15),
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      ),
    );
    Widget _complain = Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(top: 10, right: 10),
      child: Text(
        '举报简介',
        style:
            TextStyle(color: Color.fromARGB(88, 255, 255, 255), fontSize: 10),
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_title, _desc, _complain],
      ),
    );
  }
  Widget _getStaff(StaffBean staff) {
    double width = 90;
    return Container(
        width: width,
        margin: EdgeInsets.only(right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ImageUtils.getImageFromNetwork(staff.avatars.small, width, 110,
                radius: 4),
            Container(
              child: Text(
                staff.name,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              margin: EdgeInsets.only(top: 4),
            ),
            Container(
              child: Text(staff.type,
                  style: TextStyle(
                      color: Color.fromARGB(160, 255, 255, 255), fontSize: 12)),
              margin: EdgeInsets.only(top: 2),
            ),
          ],
        ));
  }
  Widget _getActors() {
    Widget _title = Text(
      '演职员',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    );

    List<Widget> _staffs = bean.directors.map((item) {
      return _getStaff(item);
    }).toList();
    _staffs.addAll(bean.casts.map((item) {
      return _getStaff(item);
    }).toList());
    Widget _list = Container(
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _staffs,
          ),
        ));

    return Container(
      margin: EdgeInsets.only(left: 14, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_title, _list],
      ),
    );
  }
  Widget _getTrailer(String image, bool isTrailer) {
    double width = 250;
    double height = 150;

    List<Widget> children = [
      ImageUtils.getImageFromNetwork(image, width, height)
    ];
    if (isTrailer) {
      children.add(Container(
        margin: EdgeInsets.only(left: 3, top: 3),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          '预告片',
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
        decoration: BoxDecoration(
            color: ImageUtils.fromHex('#F3AE47'),
            borderRadius: BorderRadius.all(Radius.circular(2))),
      ));
      children.add(Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Image.asset(
          'assets/ic_playing.png',
          width: 30,
          height: 30,
        ),
      ));
    }

    return Container(
      margin: EdgeInsets.only(right: 2),
      child: Stack(
        children: children,
      ),
    );
  }
  Widget _getPhoto() {
    List<String> photos = bean.photos.sublist(2).map((item) {
      return item.cover;
    }).toList();
    int half = (photos.length / 2).round();
    Widget _r1 = Row(
      children: photos.sublist(0, half).map((item) {
        return ImageUtils.getImageFromNetwork(item, 125, 74,
            margin: EdgeInsets.only(right: 2, bottom: 1));
      }).toList(),
    );
    Widget _r2 = Row(
      children: photos.sublist(half).map((item) {
        return ImageUtils.getImageFromNetwork(item, 125, 74,
            margin: EdgeInsets.only(right: 2, top: 1));
      }).toList(),
    );

    return Container(
      height: 150,
      child: Column(
        children: <Widget>[_r1, _r2],
      ),
    );
  }
  Widget _getPhotos() {
    Widget _title = Text(
      '预告片 / 视频评论 / 剧照',
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
    );

    List<Widget> photos = [];
    if(bean.trailers.length > 0){
      photos.add(_getTrailer(bean.trailers[0].medium, true));
    }
    if(bean.photos.length > 1){
      photos.addAll([
        _getTrailer(bean.photos[0].cover, false),
        _getTrailer(bean.photos[1].cover, false),
        _getPhoto()
      ]);
    }

    Widget _list = Container(
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: photos
          ),
        ));

    return Container(
      margin: EdgeInsets.only(left: 14, top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_title, _list],
      ),
    );
  }
  Widget _getShortComment(ShortCommentBean bean, bool isLast) {
    Widget _avatar =
        ImageUtils.getImageFromNetwork(bean.author.avatar, 30, 30, radius: 100);
    Widget _name = Text(
      bean.author.name,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
    Widget _stars = RatingBar.readOnly(
      size: 12,
      emptyColor: ImageUtils.fromHex('#C4C4C4'),
      filledColor: ImageUtils.fromHex('#F2A750'),
      initialRating: bean.rating.toDouble(),
      isHalfAllowed: true,
      halfFilledIcon: Icons.star_half,
      filledIcon: Icons.star,
      emptyIcon: Icons.star,
    );
    Widget _rating = Container(
      margin: EdgeInsets.only(left: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _name,
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Row(
              children: <Widget>[_stars],
            ),
          )
        ],
      ),
    );
    Widget _userInfo = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_avatar, _rating],
      ),
    );

    Widget _comment = Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(bean.content,
          style: TextStyle(color: Colors.white, height: 1.4),
          maxLines: 4,
          overflow: TextOverflow.ellipsis),
    );
    Widget _likeCount = Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/ic_like.png',
            width: 12,
            height: 12,
            color: Colors.white,
          ),
          Container(
            margin: EdgeInsets.only(top: 1),
            child: Text(
              ' ${bean.usefulCount}',
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          )
        ],
      ),
    );

    Color borderColor =
        isLast ? Colors.transparent : Color.fromARGB(33, 255, 255, 255);
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.5, color: borderColor))),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_userInfo, _comment, _likeCount],
      ),
    );
  }
  Widget _getShortComments() {
    Widget _title = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Text(
              '短评',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
          Text(
            '全部${bean.commentCounts}  ',
            style: TextStyle(
                color: Color.fromARGB(160, 255, 255, 255), fontSize: 13),
          ),
          Icon(Icons.arrow_forward_ios,
              size: 10, color: Color.fromARGB(160, 255, 255, 255))
        ],
      ),
    );
    List<Widget> children = [];
    for (int i = 0; i < bean.shortComments.length; i++) {
      children.add(_getShortComment(
          bean.shortComments[i], i == bean.shortComments.length - 1));
    }

    Widget _comments = Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: children,
      ),
    );

    return Container(
      margin: EdgeInsets.only(top: 40, left: 14, right: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Color.fromARGB(88, 0, 0, 0)),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[_title, _comments],
      ),
    );
  }

  Widget _getDetail() {
    if (bean == null) return _getEmptyContent();

    animationController.stop();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getBasicInfo(),
          _getRating(),
          _getTags(),
          _getIntroduction(),
          _getActors(),
          _getPhotos(),
          _getShortComments(),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
//        backgroundColor: ImageUtils.fromHex('#354c66'),
        backgroundColor: mainColor,
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.only(bottom: 20),
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[_getTitle(), _getDetail()],
          ),
        )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    HttpUtils.getMovieDetail(subjectId).then((val) {
      setState(() {
        bean = MovieDetailBean.fromJson(val);
        getColorFromUrl(bean.images.large).then((color) {
          setState(() {
            final factor = 0.75;
            final red = (color[0] * factor).round();
            final green = (color[1] * factor).round();
            final blue = (color[2] * factor).round();
            mainColor = Color.fromARGB(255, red, green, blue);
          });
        });
      });
    });

    animationController = new AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 243, end: 220).animate(animationController);

    animationController.addListener((){
      setState(() {
      });
    });
    animationController.addStatusListener((status){
      if(status == AnimationStatus.reverse){
        emptySelectedLine += 1;
        emptySelectedLine %= widths.length;
      }
    });


    animationController.repeat(reverse: true);
  }

  AnimationController animationController;
  Animation<double> animation;

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
