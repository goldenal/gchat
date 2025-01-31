// To parse this JSON data, do
//
//     final userdata = userdataFromJson(jsonString);

import 'dart:convert';

Userdata userdataFromJson(String str) => Userdata.fromJson(json.decode(str));

String userdataToJson(Userdata data) => json.encode(data.toJson());

class Userdata {
  List<MyUser>? myUser;

  Userdata({
    this.myUser,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        myUser: json["MyUser"] == null
            ? []
            : List<MyUser>.from(json["MyUser"]!.map((x) => MyUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "MyUser": myUser == null
            ? []
            : List<dynamic>.from(myUser!.map((x) => x.toJson())),
      };
}

class MyUser {
  String? name;
  String? id;
  String? language;

  MyUser({this.name, this.id, this.language});

  factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
        name: json["name"],
        id: json["id"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "language": language,
      };
}
