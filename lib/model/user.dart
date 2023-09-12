class User {
  String id;
  String username;
  String password;
  String image;
  String createdAt;
  String updatedAt;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  toJson() {}
}
