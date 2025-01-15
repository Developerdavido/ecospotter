


import 'package:citizen_app/core/config/services/auth_service.dart';
import 'package:citizen_app/core/config/services/campaign_service.dart';
import 'package:citizen_app/core/config/services/dialog_service.dart';
import 'package:citizen_app/core/config/services/navigation_service.dart';
import 'package:citizen_app/core/data/datasources/auth/auth_data_source.dart';
import 'package:citizen_app/core/domain/repositories/auth_repository.dart';
import 'package:citizen_app/core/domain/usecases/auth/login_user.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton<DialogService>(() => DialogService());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<CampaignService>(() => CampaignService());
  locator.registerLazySingleton<NavService>(() => NavService());


  //use cases locator
  locator.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
}