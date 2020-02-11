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
}
