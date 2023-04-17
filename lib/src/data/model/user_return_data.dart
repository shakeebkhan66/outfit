class UserReturnData {
  String? message;
  List<Data>? data;

  UserReturnData({this.message, this.data});

  UserReturnData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? uid;
  String? firstName;
  String? lastName;
  String? type;
  String? email;
  String? mobile;
  String? lang;
  String? dateCreated;

  Data(
      {this.uid,
      this.firstName,
      this.lastName,
      this.type,
      this.email,
      this.mobile,
      this.lang,
      this.dateCreated});

  Data.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    type = json['type'];
    email = json['email'];
    mobile = json['mobile'];
    lang = json['lang'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['type'] = type;
    data['email'] = email;
    data['mobile'] = mobile;
    data['lang'] = lang;
    data['date_created'] = dateCreated;
    return data;
  }
}