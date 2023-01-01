class LoginModel {
  LoginModel({
    this.name,
    this.password,
  });

  String name;
  String password;

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
      };
}
