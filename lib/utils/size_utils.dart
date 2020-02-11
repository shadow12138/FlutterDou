import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeUtils {
  static final double screenWidth = 720;
  static final double screenHeight = 1560;

  static void init(BuildContext context){
    ScreenUtil.init(context, width: screenWidth, height: screenHeight);
  }

  static double getWidth(double width) {
    return ScreenUtil().setWidth(width);
  }

  static double getHeight(double height) {
    return ScreenUtil().setWidth(height);
  }

  static double getScreenWidth() {
    return getWidth(screenWidth);
  }
}
