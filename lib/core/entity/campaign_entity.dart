

class CampaignEntity {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;

  const CampaignEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
  });

}