

class RankingEntity {
  final String id;
  final String userId;
  final num points;
  final String username;
  final String imageUrl;

  const RankingEntity({
    required this.id,
    required this.userId,
    required this.points,
    required this.username,
    required this.imageUrl,
  });
}