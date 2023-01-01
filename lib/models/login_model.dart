class LoginResponseModel {
  LoginResponseModel({
    this.accessToken,
    this.userId,
  });

  String accessToken;
  int userId;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        accessToken: json["access_token"],
        userId: json["userId"],
      );
}
