

import 'package:citizen_app/core/domain/repositories/auth_repository.dart';

import '../../../data/models/user_model.dart';

class UpdateUser {
  final AuthRepository repository;

  UpdateUser(this.repository);

  Future<List<Map<String, dynamic>>> call(Map<String, dynamic> data) async {
    return repository.saveUserToDb(data);
  }
}