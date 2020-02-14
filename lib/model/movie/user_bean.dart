class UserBean {
  String uid;
  String avatar;
  String signature;
  String alt;
  String id;
  String name;

  UserBean({this.uid, this.avatar, this.signature, this.alt, this.id, this.name});

  UserBean.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    avatar = json['avatar'];
    signature = json['signature'];
    alt = json['alt'];
    id = json['id'];
    name = json['name'];
  }

}