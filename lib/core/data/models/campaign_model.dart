

import 'package:citizen_app/core/entity/campaign_entity.dart';

class CampaignModel extends CampaignEntity {
  CampaignModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.status,
    required super.createdAt,
    required super.startDate,
    required super.endDate});

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
        id: json['id'] ?? "",
        title: json['title'] ?? "",
        description: json['description'] ?? "",
        status: json['status'] ?? "",
        createdAt: DateTime.parse(json['created_at']),
        startDate: DateTime.parse(json['start_date']),
        endDate: DateTime.parse(json['end_date']),
      imageUrl: json['image_url'],);
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'description' : description,
      'status' : status,
      'created_at' : createdAt.toIso8601String(),
      'start_date' : startDate.toIso8601String(),
      'end_date' : endDate.toIso8601String(),
      'image_url' : imageUrl,
    };
  }

}