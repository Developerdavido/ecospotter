

class CampaignEntity {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String status;
  final String type;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;

  const CampaignEntity({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.type,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
  });

}