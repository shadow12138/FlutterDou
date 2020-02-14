class ImagesBean{
  String small;
  String medium;
  String large;

  ImagesBean.fromJson(Map<String, dynamic> subject){
    small = subject['small'];
    medium = subject['medium'];
    large = subject['large'];
  }
}