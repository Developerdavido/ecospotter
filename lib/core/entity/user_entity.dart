class UserEntity {
  final String id;
  final String? avatarUrl;
  final String? speciesOfInterest;
  final String? email;
  final num? points;
  final DateTime createdAt;
  final String? profession;

  UserEntity(
      {required this.id,
      this.avatarUrl,
        this.email,
      this.speciesOfInterest,
      this.points,
      required this.createdAt,
      this.profession});
}
