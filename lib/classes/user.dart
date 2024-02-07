class User {
  int? id;
  String? username;
  String? email;
  String? password;

  User(
    this.id,
    this.username,
    this.email,
    this.password,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['username'],
      json['email'],
      json['password'],
    );
  }
}
