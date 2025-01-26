import 'package:citizen_app/core/entity/capture_entity.dart';

class CaptureModel extends CaptureEntity {
  CaptureModel({
    required super.id,
    required super.userId,
    required super.specieName,
    required super.imageUrl,
    required super.latitude,
    required super.longitude,
    required super.animalActivity,
    super.animalLocationFeature,
    required super.createdAt,
    required super.campaignId,
    required super.username,
    required super.favorites,
    super.verificationPoints,
    super.verified
  });

  factory CaptureModel.fromJson(Map<String, dynamic> json) {
    return CaptureModel(
        id: json['id'],
        userId: json['user_id'],
        username: json['username'],
        specieName: json['species_name'],
        imageUrl: json['image_url'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        animalActivity: json['animal_activity'],
        animalLocationFeature: json['animal_location_type'],
        createdAt: DateTime.parse(json['captured_at']),
        campaignId: json['campaign_id'],
        verificationPoints: json['verification_points'],
        verified: json['verified'],
        favorites: json['favorites'] == null
            ? []
            : List<String>.from(json['favorites'].map((x) => x.toString()).toList()));
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'species_name': specieName,
      'image_url': imageUrl,
      'username': username,
      'latitude': latitude,
      'longitude': longitude,
      'favorites': [],
      'animal_activity': animalActivity,
      'verification_points': 0,
      'verified': false,
      'campaign_id': campaignId,
    };
  }
}
