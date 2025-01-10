

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
    required super.animalLocationFeature,
    required super.createdAt,
    required super.campaignId,
    required super.username,
  });

  factory CaptureModel.fromJson(Map<String, dynamic> json) {
    return CaptureModel(
        id: json['id'],
        userId: json['uuid'],
        username: json['username'],
        specieName: json['species_name'],
        imageUrl: json['image_url'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        animalActivity: json['animal_activity'],
        animalLocationFeature: json['animal_location_type'],
        createdAt: json['created_at'],
        campaignId: json['campaign_id']);
  }

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'user_id': userId,
      'species_name': specieName,
      'image_url': imageUrl,
      'username': username,
      'latitude': latitude,
      'longitude': longitude,
      'animal_activity': animalActivity,
      'animal_location_type': animalLocationFeature,
      'createdAt': createdAt,
      'campaign_id': campaignId,
    };
  }

}