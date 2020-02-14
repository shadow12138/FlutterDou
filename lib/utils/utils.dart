import 'dart:convert';

class Utils {
  static String getPrettyNumber(int number){
    if (number < 10000)
      return '$number';
    int tenThousand = (number / 10000).floor();
    number = (number - 10000 * tenThousand).round();
    int thousand = (number / 1000).floor();
    return '$tenThousand.$thousand万';
  }

}
