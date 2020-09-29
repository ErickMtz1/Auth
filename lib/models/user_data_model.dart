// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.name,
        this.uuid,
        this.registerDate,
        this.app,
    });

    String name;
    String uuid;
    DateTime registerDate;
    String app;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        uuid: json["uuid"],
        registerDate: DateTime.parse(json["register_date"]),
        app: json["app"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "uuid": uuid,
        "register_date": registerDate.toIso8601String(),
        "app": app,
    };
}
