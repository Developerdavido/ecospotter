


import 'dart:io';

import 'package:citizen_app/core/domain/repositories/auth_repository.dart';

class UpdateUserAvatar {
  final AuthRepository repository;

  UpdateUserAvatar(this.repository);

  Future<dynamic> call(String imagePath, String userId) async {
    return repository.updateUserAvatar(imagePath, userId);
  }

}