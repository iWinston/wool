class NewsModel {
  List<NewsItem> data;
  String status;

  NewsModel({this.data, this.status});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<NewsItem>();
      json['data'].forEach((v) {
        data.add(new NewsItem.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class NewsItem {
  int id;
  String createdAt;
  String updatedAt;
  String deletedAt;
  int userId;
  String content;
  String photoPath;
  String location;
  User user;

  NewsItem(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.userId,
        this.content,
        this.photoPath,
        this.location,
        this.user
      });

  NewsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    userId = json['userId'];
    content = json['content'];
    photoPath = json['photoPath'];
    location = json['location'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['userId'] = this.userId;
    data['content'] = this.content;
    data['photoPath'] = this.photoPath;
    data['location'] = this.location;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String name;
  String phone;
  String avatorPath;
  int point;

  User(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.name,
        this.phone,
        this.avatorPath,
        this.point});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    name = json['name'];
    phone = json['phone'];
    avatorPath = json['avatorPath'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['avatorPath'] = this.avatorPath;
    data['point'] = this.point;
    return data;
  }
}