import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/url_config.dart';
import 'package:flutter_app/model/tv_bean.dart';
import 'package:flutter_app/utils/http_utils.dart';
import 'package:flutter_app/utils/image_utils.dart';
import 'package:rating_bar/rating_bar.dart';

class TvRecommendWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TvRecommendState();
  }
}

class TvRecommendState extends State<TvRecommendWidget> {
  List<TvBean> recommends;
  double itemHeight = 130;

  Widget _getTitle() {
    return Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 10),
        child: Text('为你推荐',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)));
  }

  Widget _getItem(TvBean bean) {
    return Container(
      padding: EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 230, 230, 230), width: 0.5))),
      margin: EdgeInsets.only(left: 14, right: 14, bottom: 16),
      alignment: Alignment.topLeft,
      child: Row(
        children: <Widget>[
          Container(
            height: itemHeight + 10,
            alignment: Alignment.topLeft,
            child: ImageUtils.getImageFromNetwork(bean.image, 100, itemHeight,
                radius: 4),
          ),
          Expanded(
            child: _getDetail(bean),
          )
        ],
      ),
    );
  }

  Widget _getLeft(TvBean bean) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.topLeft,
          child: Row(
            children: <Widget>[
              Text(
                bean.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Row(
            children: <Widget>[
              RatingBar.readOnly(
                size: 12,
                filledColor: Color.fromARGB(255, 240, 173, 70),
                emptyColor: Color.fromARGB(255, 202, 202, 202),
                initialRating: bean.rating / 2,
                isHalfAllowed: true,
                halfFilledIcon: Icons.star_half,
                filledIcon: Icons.star,
                emptyIcon: Icons.star,
              ),
              Container(
                margin: EdgeInsets.only(left: 2, top: 1),
                child: Text(
                  '${bean.rating}',
                  style: TextStyle(fontSize: 10, color: Colors.black54),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 6),
          child: Text(
            bean.desc,
            style: TextStyle(color: ImageUtils.fromHex('#595959')),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }



  Widget _getDetail(TvBean bean) {
    return Container(
      margin: EdgeInsets.only(left: 8),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          _getLeft(bean),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: ImageUtils.fromHex('#F7F7F7'),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Text(
                      '你可能感兴趣',
                      style: TextStyle(color: ImageUtils.fromHex('#818181')),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getList() {
    if (recommends == null) return Container();
    return Container(
      child: Column(
        children: recommends.map((item) {
          return _getItem(item);
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_getTitle(), _getList()],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    HttpUtils.getTvHttp(TvUrlConfig.getRecommend).then((val) {
      setState(() {
        recommends = TvBean.getList(val);
      });
    });
  }
}
