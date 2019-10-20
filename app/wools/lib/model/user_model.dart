import 'package:wools/model/tags_model.dart';

class UserInfoModel {
  UserModel data;
  String status;

  UserInfoModel({this.data, this.status});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserModel.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class UserModel {
  int id;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String name;
  String phone;
  String avatorPath;
  int point;
  List<TagItem> tags;

  UserModel(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.name,
        this.phone,
        this.avatorPath,
        this.point,
        this.tags});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    name = json['name'];
    phone = json['phone'];
    avatorPath = json['avatorPath'];
    point = json['point'];
    if (json['tags'] != null) {
      tags = new List<TagItem>();
      json['tags'].forEach((v) {
        tags.add(new TagItem.fromJson(v));
      });
    }
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
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

