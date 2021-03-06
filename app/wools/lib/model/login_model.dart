

class LoginModel {
  int id;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String name;
  String phone;
  String avatorPath;
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