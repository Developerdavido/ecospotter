
import 'package:citizen_app/core/data/datasources/auth/auth_data_source.dart';
import 'package:citizen_app/core/data/models/user_model.dart';
import 'package:citizen_app/core/domain/repositories/auth_repository.dart';
import 'package:gotrue/src/types/auth_response.dart';

class AuthRepositoryImplementation implements AuthRepository {
  final AuthDataSource authDataSource;


  AuthRepositoryImplementation(this.authDataSource);


  //Login the user the get that flow
  @override
  Future<AuthResponse> loginUser() async {
    // TODO: implement loginUser
    return await authDataSource.loginUser();
  }

  @override
  Future<UserModel> updateUser(Map<String, dynamic> userData) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<String> updateUserAvatar(String id) {
    // TODO: implement updateUserAvatar
    throw UnimplementedError();
  }

}