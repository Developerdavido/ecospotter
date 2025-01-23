


import 'package:citizen_app/core/domain/repositories/auth_repository.dart';

class GetUserById {
  final AuthRepository repository;

  const GetUserById({
    required this.repository,
  });

  Future<List<Map<String,dynamic>>> call(String id) async {
    return await repository.getUserById(id);
  }
}