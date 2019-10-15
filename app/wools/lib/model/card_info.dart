class CardInfoModel {
  String nickname;
  String content;
  String avatar;
  String address;
  String pic;
  DateTime date;
  int likes;

  CardInfoModel({this.nickname, this.content, this.avatar, this.address, this.date, this.likes});

  CardInfoModel.fromJson(Map<String, dynamic> json) {
    nickname = json['title'];
    content = json['content'];
    avatar = json['avatar'];
    address = json['address'];
    date = json['date'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['conent'] = this.content;
    data['avatar'] = this.avatar;
    data['address'] = this.address;
    data['date'] = this.date;
    data['likes'] = this.likes;
    return data;
  }
}