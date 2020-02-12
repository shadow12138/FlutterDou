import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rating_bar/rating_bar.dart';

class ImageUtils {
  static Widget getImageFromNetwork(String url, double width, double height,
      {double radius, EdgeInsets margin, Alignment alignment, Border border, BoxFit fit}) {
    DecorationImage decorationImage =
        DecorationImage(image: NetworkImage(url), fit: fit == null ? BoxFit.cover: fit);
    BorderRadius borderRadius =
        radius != null ? BorderRadius.all(Radius.circular(radius)) : null;

    Widget image = Container(
      alignment: alignment,
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: borderRadius, image: decorationImage, border: border),
    );

    return image;
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Widget getRating(double rating, {EdgeInsets margin}){
    return Container(
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RatingBar.readOnly(
            size: 12,
            emptyColor: ImageUtils.fromHex('#C4C4C4'),
            filledColor: ImageUtils.fromHex('#F2A750'),
            initialRating: rating / 2,
            isHalfAllowed: true,
            halfFilledIcon: Icons.star_half,
            filledIcon: Icons.star,
            emptyIcon: Icons.star,
          ),
          Container(
            margin: EdgeInsets.only(left: 4, top: 1),
            child: Text('$rating', style: TextStyle(color: ImageUtils.fromHex('#7C7C7C'), fontSize: 10),),
          )
        ],
      ),
    );
  }

  static Widget getTitle(String title, {int count=0, EdgeInsets margin}){

    List<Widget> children = [Expanded(
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    )];

    if(count > 0){
      Widget _r1 = Text('全部 $count', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),);
      Widget _r2 = Container(
        margin: EdgeInsets.only(left: 2, top: 2),
        child: Icon(Icons.arrow_forward_ios, size: 12,),
      );
      children.addAll([_r1, _r2]);
    }

    return Container(
      margin: margin,
      child: Row(
        children: children,
      ),
    );
  }

  static Color getTextColor1() => fromHex('#333333');
  static Color getTextColor2() => fromHex('#666666');
  static Color getTextColor3() => fromHex('#999999');
  static Color getDividerColor() => fromHex('#E3E3E3');
  static Color getBackgroundColor() => fromHex('#f7f7f7');
}
