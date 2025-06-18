class AppUser {
  final String username;
  final String email;
  final String alamat;
  final String password;

  AppUser({
    required this.username,
    required this.email,
    required this.alamat,
    required this.password,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
    username: json['username'] ?? '',
    email: json['email'] ?? '',
    alamat: json['alamat'] ?? '',
    password: json['password'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'alamat': alamat,
    'password': password,
  };

  AppUser copyWith({
    String? username,
    String? email,
    String? alamat,
    String? password,
  }) {
    return AppUser(
      username: username ?? this.username,
      email: email ?? this.email,
      alamat: alamat ?? this.alamat,
      password: password ?? this.password,
    );
  }
}
