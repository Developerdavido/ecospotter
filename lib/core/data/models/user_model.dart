import 'package:citizen_app/core/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    super.createdAt,
    super.updatedAt,
    super.avatarUrl,
    super.speciesOfInterest,
    super.email,
    super.username,
    super.points,
    super.profession,
    required super.role,
    super.displayName,
    required super.sex,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      avatarUrl: json['avatar_url'],
      speciesOfInterest: json['species_of_interest'],
      email: json['email'],
      points: json['points'],
      sex: json['sex'],
      createdAt: DateTime.parse(json['created_at']),
      profession: json['profession'],
      role: json['role'],
      displayName: json['display_name'],
    );
  }

  Map<String,dynamic> toMap() {
    return {
      'id': id,
      'avatar_url': avatarUrl,
      'species_of_interest': speciesOfInterest,
      'points': points,
      'profession': profession,
      'username': username,
      'role': role,
      'sex': sex,
      'display_name': displayName,
    };
  }
}
