class ResponseResultUserModel {
  int? status;
  String? message;
  UserModel? data;

  ResponseResultUserModel({
    this.status,
    this.message,
    this.data,
  });

  factory ResponseResultUserModel.fromJson(Map<String, dynamic> json) =>
      ResponseResultUserModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? profileImage;

  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "profile_image": profileImage,
      };
}
