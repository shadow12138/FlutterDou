class RatingBean{
  int max;
  int min;
  double average;
  String stars;
  List<int> details;

  RatingBean.fromJson(Map<String, dynamic> subject){
    max = subject['max'];
    min = subject['min'];
    average = subject['average'] * 1.0;
    stars = subject['stars'];

    List<int> ratings = [];
    for(int i = 1; i <= 5; i++){
      ratings.add(subject['details'][i.toString()].round());
    }
    details = ratings;
  }
}
