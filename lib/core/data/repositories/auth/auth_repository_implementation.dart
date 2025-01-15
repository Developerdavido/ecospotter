
import 'package:citizen_app/core/data/datasources/auth/auth_data_source.dart';
import 'package:citizen_app/core/data/models/auth_model.dart';
import 'package:citizen_app/core/data/models/user_model.dart';
import 'package:citizen_app/core/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthDataSource authDataSource;


  AuthRepositoryImplementation(this.authDataSource);


  //Login the user the get that flow
  @override
  Future<AuthModel> loginUser() async {

    return await authDataSource.loginUser();
  }

  @override
  Future<UserModel> updateUser(Map<String, dynamic> userData) async {
    return await authDataSource.updateUser(userData);
  }

  @override
  Future<dynamic> updateUserAvatar(String imagePath, String userId) async {
    // TODO: implement updateUserAvatar
    return await authDataSource.updateAvatar(imagePath, userId);
  }

  @override
  Future<List<Map>> checkIfUsernameExists(String username) async {
    // TODO: implement checkIfUsernameExists
    return await authDataSource.getUsername(username);
  }

}