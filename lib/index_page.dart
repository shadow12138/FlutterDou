import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/pages/book/book_page.dart';
import 'package:flutter_app/pages/city_page.dart';
import 'package:flutter_app/pages/film/film_page.dart';
import 'package:flutter_app/pages/music/music_page.dart';
import 'package:flutter_app/pages/novel/novel_page.dart';
import 'package:flutter_app/pages/tv/tv_page.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:flutter_app/utils/size_utils.dart';
import 'package:provider/provider.dart';

class PageNotifier with ChangeNotifier {
  int page = 3;

  void setPage(int page) {
    this.page = page;
    notifyListeners();
  }
}

class IndexPage extends StatelessWidget{
  List<Widget> pages = [FilmPage(), TvPage(), BookPage(), NovelPage(), MusicPage(), CityPage()];

  @override
  Widget build(BuildContext context) {
    final pageNotifier = Provider.of<PageNotifier>(context);

    SizeUtils.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: pages[pageNotifier.page],
    );
  }
}


class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  double iconSize = 22;
  Color iconColor = Color.fromARGB(255, 100, 100, 100);
  List<String> tabs = ['电影', '电视', '读书', '原创小说', '音乐', '同城'];

  Widget _getSearch() {
    Widget left = Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 14),
        height: 34,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 235, 235, 235),
            borderRadius: BorderRadius.all(Radius.circular(100))),
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/ic_search.png',
              width: iconSize,
              height: iconSize,
              color: iconColor,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(
                  '动画番剧小组',
                  style: TextStyle(color: Color.fromARGB(255, 192, 192, 192)),
                ),
              ),
            ),
            Image.asset(
              'assets/ic_scan.png',
              width: iconSize,
              height: iconSize,
              color: iconColor,
            ),
          ],
        ),
      ),
    );
    Widget right = Container(
      margin: EdgeInsets.only(left: 16, right: 14),
      child: Image.asset(
        'assets/ic_mail.png',
        width: iconSize,
        height: iconSize,
        color: iconColor,
      ),
    );
    return Row(
      children: <Widget>[left, right],
    );
  }

  Widget _getTab(BuildContext context){

    final pageNotifier = Provider.of<PageNotifier>(context);

    List<Widget> children = [];
    for(int i = 0; i < tabs.length; i++){
      String title = tabs[i];
      bool selected = i == pageNotifier.page;
      Color textColor = selected ? Colors.black : Colors.black54;
      FontWeight fontWeight = selected ? FontWeight.bold : FontWeight.normal;
      children.add(InkWell(
        onTap: (){
          pageNotifier.setPage(i);
        },

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
//          margin: EdgeInsets.only(right: 3),
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: selected ? Colors.black : Colors.transparent, width: 2))),
            child: Text(title, style: TextStyle(color: textColor, fontWeight: fontWeight),),
          ),
        ),
      ));
    }

    return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 10),
      child: Row(children: children,),
    );
  }

  Widget _getDivider(){
    return Container(
      height: 0.5,
      color: ImageUtils.fromHex("#eeeeee"),

    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 40),
      child: Column(
        children: <Widget>[_getSearch(), _getTab(context), _getDivider(),],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(100, 100);
}