import 'dart:ui';

import 'package:flutter_app/model/tv/tv_bean.dart';
import 'package:flutter_app/utils/image_utils.dart';

import 'book_bean.dart';

class BookRankBean{
  String title;
  List<BookBean> bookList;
  String image;
  Color mainColor;

  static BookRankBean getItem(Map<String, dynamic> subject){
    String title = subject['title'];
    String color = subject['color'];
    String image = subject['image'];
    List<BookBean> bookList = BookBean.getList(subject['subjects']);

    BookRankBean bean = BookRankBean();
    bean.title = title;
    bean.bookList = bookList;
    bean.image = image;
    bean.mainColor = ImageUtils.fromHex(color);
    return bean;
  }

  static List<BookRankBean> getList(List<dynamic> subjects){
    List<BookRankBean> items = [];
    for(Map<String, dynamic> subject in subjects){
      items.add(getItem(subject));
    }
    return items;
  }

  @override
  String toString() {
    return this.bookList.toString();
  }
}