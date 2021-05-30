// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

UserInfo welcomeFromJson(String str) => UserInfo.fromJson(json.decode(str));

String welcomeToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    this.id,
    this.firstname,
    this.lastname,
    this.contactno,
    this.email,
    this.imgurl,
    this.v,
  });

  String id;
  String firstname;
  String lastname;
  String contactno;
  String email;
  String imgurl;
  int v;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["_id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        contactno: json["contactno"],
        email: json["email"],
        imgurl: json["imgurl"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstname": firstname,
        "lastname": lastname,
        "contactno": contactno,
        "email": email,
        "imgurl": imgurl,
        "__v": v,
      };
}
