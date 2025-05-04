class BadgeModel {
  final String id;
  final String name;
  final String description;
  final int pointsRequired;
  final String iconUrl;

  BadgeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pointsRequired,
    required this.iconUrl,
  });

  factory BadgeModel.fromJson(Map<String, dynamic> json) {
    return BadgeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pointsRequired: json['points_required'],
      iconUrl: json['icon_url'],
    );
  }
}
