import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) =>
    json.encode(data.toJson());

class UserDataModel {
  int statusCode;
  bool success;
  String message;
  UserData data;
  dynamic meta;

  UserDataModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        statusCode: json["statusCode"] ?? 0,
        success: json["success"] ?? false,
        message: json["message"] ?? "No message",
        data: json["data"] != null
            ? UserData.fromJson(json["data"])
            : UserData(doctorEmail: "",doctorId: "", accessToken: "", refreshToken: ""),
        meta: json["meta"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "data": data.toJson(),
        "meta": meta,
      };
}

class UserData {
  String doctorId;
  String accessToken;
  String refreshToken;
  String doctorEmail;

  UserData({
    required this.doctorId,
    required this.accessToken,
    required this.refreshToken,
    required this.doctorEmail,

  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        doctorEmail: json["doctorEmail"] ?? "",
        doctorId: json["doctorId"] ?? "",
        accessToken: json["accessToken"] ?? "",
        refreshToken: json["refreshToken"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "doctorId": doctorId,
        "doctorEmail": doctorEmail,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class User {
  String id;
  String phone;
  String role;

  User({
    required this.id,
    required this.phone,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? "",
        phone: json["phone"] ?? "",
        role: json["role"] ?? "user",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "role": role,
      };
}
