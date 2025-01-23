

import 'package:citizen_app/core/entity/campaign_entity.dart';

class CampaignModel extends CampaignEntity {
  CampaignModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.status,
    required super.type,
    required super.createdAt,
    required super.startDate,
    required super.endDate});

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
        id: json['id'] ?? "",
        title: json['title'] ?? "",
        type: json['type'] ?? "",
        description: json['description'] ?? "",
        status: json['status'] ?? "",
        createdAt: DateTime.parse(json['created_at']),
        startDate: DateTime.parse(json['start_date']),
        endDate: DateTime.parse(json['end_date']),
      imageUrl: json['image_url'],);
  }

}