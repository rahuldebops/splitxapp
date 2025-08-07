class UserModel {
  final String userId;
  final String name;
  final String email;
  final String accessToken;
  final String refreshToken;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJwt(Map<String, dynamic> json, String accessToken, String refreshToken) {
    return UserModel(
      userId: json['UserId'] ?? '',
      name: json['UserId'] ?? '',
      email: json['Email'] ?? '',
      accessToken: accessToken,
      refreshToken: refreshToken,      
    );
  }
}
