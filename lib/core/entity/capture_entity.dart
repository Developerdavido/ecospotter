

class CaptureEntity {
  final String id;
  final String userId;
  final String specieName;
  final String imageUrl;
  final num latitude;
  final num longitude;
  final num animalActivity;
  final String animalLocationFeature;
  final String campaignId;
  final DateTime createdAt;

  const CaptureEntity({
    required this.id,
    required this.userId,
    required this.specieName,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.animalActivity,
    required this.animalLocationFeature,
    required this.createdAt,
    required this.campaignId,
  });
}