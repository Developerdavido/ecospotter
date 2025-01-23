
import 'package:citizen_app/core/data/datasources/auth/auth_data_source.dart';
import 'package:citizen_app/core/data/models/auth_model.dart';
import 'package:citizen_app/core/data/models/user_model.dart';
import 'package:citizen_app/core/domain/repositories/auth_repository.dart';

import '../../../../config/locator.dart';

class AuthRepositoryImplementation implements AuthRepository {

  //locate the auth data source
  final authDataSource = locator<AuthDataSource>();

  //Login the user the get that flow
  @override
  Future<AuthModel?>? loginUser() async {

    return await authDataSource.loginUser();
  }

  @override
  Future<List<Map<String, dynamic>>> saveUserToDb(Map<String, dynamic> userData) async {
    return await authDataSource.saveUserToDb(userData);
  }

  @override
  Future<String> updateUserAvatar(String imagePath, String userId) async {
    return await authDataSource.uploadAvatar(imagePath, userId);
  }

  @override
  Future<List<Map<String, dynamic>>> checkIfUsernameExists(String username) async {

    return await authDataSource.getUsername(username);
  }

  @override
  Future<List<Map<String, dynamic>>> getUserById(String id) async {
    return await authDataSource.getUserById(id);
  }

}