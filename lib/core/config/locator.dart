


import 'package:citizen_app/core/config/services/dialog_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton<DialogService>(() => DialogService());

}