
class UserBadgeModel {
  final String badgeId;
  final DateTime earnedAt;
  final bool isViewed;

  UserBadgeModel({
    required this.badgeId,
    required this.earnedAt,
    this.isViewed = false,
  });

  factory UserBadgeModel.fromJson(Map<String, dynamic> json) {
    return UserBadgeModel(
      badgeId: json['badge_id'],
      earnedAt: DateTime.parse(json['earned_at']),
      isViewed: json['is_viewed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'badge_id': badgeId,
      'earned_at': earnedAt.toIso8601String(),
      'is_viewed': isViewed,
    };
  }
}