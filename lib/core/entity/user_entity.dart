class UserEntity {
  final String id;
  final String? avatarUrl;
  final List<dynamic>? speciesOfInterest;
  final String? email;
  final String? username;
  final String? displayName;
  final num? points;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? profession;
  final String role;
  final String sex;

  UserEntity(
      {required this.id,
      this.avatarUrl,
      this.username,
      this.email,
      this.updatedAt,
      this.displayName,
      this.speciesOfInterest,
      this.points,
      required this.sex,
      this.createdAt,
      required this.role,
      this.profession});
}
