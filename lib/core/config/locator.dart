


import 'package:citizen_app/core/config/services/auth_service.dart';
import 'package:citizen_app/core/config/services/dialog_service.dart';
import 'package:citizen_app/core/config/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton<DialogService>(() => DialogService());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<NavService>(() => NavService());
}