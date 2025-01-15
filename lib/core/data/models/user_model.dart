

import 'package:citizen_app/core/entity/user_entity.dart';

class UserModel extends UserEntity {


  UserModel({
    required super.id,
    required super.createdAt,
    super.avatarUrl,
    super.speciesOfInterest,
    super.email,
    super.points,
    super.profession,
    required super.role,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        avatarUrl: json['avatar_url'],
        speciesOfInterest: json['species_of_interest'],
        email: json['email'],
        points: json['points'],
        createdAt: json['created_at'],
        profession: json['profession'],
        role: json['role']
    );
  }


  Map toMap() {
    return {
      'id' : id,
      'avatar_url': avatarUrl,
      'species_of_interest': speciesOfInterest,
      'email': email,
      'points': points,
      'profession': profession,
      'role':role,
      'created_at': createdAt.toIso8601String()
    };
  }

}