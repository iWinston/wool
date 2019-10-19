//class LoginModel {
//  Data data;
//  String status;
//
//  LoginModel({this.data, this.status});
//
//  LoginModel.fromJson(Map<String, dynamic> json) {
//    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//    status = json['status'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.data != null) {
//      data['data'] = this.data.toJson();
//    }
//    data['status'] = this.status;
//    return data;
//  }
//}

class LoginModel {
  int id;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  Null name;
  String phone;
  Null avatorPath;
  int point;
  String token;
  int expired;

  LoginModel(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.name,
        this.phone,
        this.avatorPath,
        this.point,
        this.token,
        this.expired});

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    name = json['name'];
    phone = json['phone'];
    avatorPath = json['avatorPath'];
    point = json['point'];
    token = json['token'];
    expired = json['expired'];
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
    data['token'] = this.token;
    data['expired'] = this.expired;
    return data;
  }
}