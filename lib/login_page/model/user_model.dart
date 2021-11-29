import 'dart:convert';

class User {
  User({
    this.data,
  });

  Data? data;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data == null ? null : data!.toMap(),
      };
}

class Data {
  Data({
    this.profilePic,
    this.name,
    this.emailId,
  });

  String? profilePic;
  String? name;
  String? emailId;

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        profilePic: json["profile_pic"] == null ? null : json["profile_pic"],
        name: json["name"] == null ? null : json["name"],
        emailId: json["email_id"] == null ? null : json["email_id"],
      );

  Map<String, dynamic> toMap() => {
        "profile_pic": profilePic == null ? null : profilePic,
        "name": name == null ? null : name,
        "email_id": emailId == null ? null : emailId,
      };
}
