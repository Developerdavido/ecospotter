


import 'dart:io';

import 'package:citizen_app/core/domain/repositories/auth_repository.dart';

class UpdateUserAvatar {
  final AuthRepository repository;

  UpdateUserAvatar(this.repository);

  Future<String> call(String userId, File image) async {
    return repository.updateUserAvatar(userId);
  }

}