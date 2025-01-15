

import 'package:citizen_app/core/domain/repositories/auth_repository.dart';

class GetUsername {
  final AuthRepository repository;

  GetUsername(this.repository);

  Future<List<Map<dynamic,dynamic>>> call(String typedValue) async {
    return repository.checkIfUsernameExists(typedValue);
  }
}