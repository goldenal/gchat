

import 'dart:convert';

MyUser userFromJson(String str) => MyUser.fromJson(json.decode(str));

String userToJson(MyUser data) => json.encode(data.toJson());

class MyUser {
    String? name;
    String? id;

    MyUser({
        this.name,
        this.id,
    });

    factory MyUser.fromJson(Map<String, dynamic> json) => MyUser(
        name: json["name"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
    };
}
