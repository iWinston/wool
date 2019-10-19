class TagsModel {
  List<TagItem> data;
  String status;

  TagsModel({this.data, this.status});

  TagsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<TagItem>();
      json['data'].forEach((v) {
        data.add(new TagItem.fromJson(v));
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

class TagItem {
  int id;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String name;

  TagItem({this.id, this.createdAt, this.updatedAt, this.deletedAt, this.name});

  TagItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['name'] = this.name;
    return data;
  }
}