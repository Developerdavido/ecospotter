

class CaptureEntity {
  final String id;
  final String userId;
  final String username;
  final String specieName;
  final String imageUrl;
  final num latitude;
  final num longitude;
  final List<String> favorites;
  final String animalActivity;
  final String? animalLocationFeature;
  final String campaignId;
  final DateTime createdAt;
  final bool? verified;
  final num? verificationPoints;

  const CaptureEntity( {
    required this.id,
    required this.userId,
    required this.specieName,
    required this.imageUrl,
    required this.favorites,
    required this.latitude,
    required this.username,
    required this.longitude,
    required this.animalActivity,
    this.animalLocationFeature,
    required this.createdAt,
    required this.campaignId,
    this.verified,
    this.verificationPoints
  });
}