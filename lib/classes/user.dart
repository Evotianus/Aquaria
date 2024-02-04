class User {
  String? username;
  String? email;
  String? password;

  // getter
  User(
    this.username,
    this.email,
    this.password,
  );

  // object to json
  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
      };

  // json to object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["username"],
      json["email"],
      json["password"],
    );
  }
}
