class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJwt(Map<String, dynamic> json) {
    return UserModel(
      id: json['sub'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
