// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    final String email;
    final String password;

    UserModel({
        required this.email,
        required this.password,
    });

    UserModel copyWith({
        String? email,
        String? password,
    }) => 
        UserModel(
            email: email ?? this.email,
            password: password ?? this.password,
        );

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
    };
}
