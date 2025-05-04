

import 'package:citizen_app/config/services/ai_service.dart';
import 'package:citizen_app/config/services/auth_service.dart';
import 'package:citizen_app/config/services/campaign_service.dart';
import 'package:citizen_app/config/services/dialog_service.dart';
import 'package:citizen_app/config/services/http_service.dart';
import 'package:citizen_app/config/services/image_service.dart';
import 'package:citizen_app/config/services/location_service.dart';
import 'package:citizen_app/config/services/navigation_service.dart';
import 'package:citizen_app/core/data/datasources/auth/auth_data_source.dart';
import 'package:citizen_app/core/data/datasources/badge_service.dart';
import 'package:citizen_app/core/data/datasources/campaign_data_source.dart';
import 'package:citizen_app/core/data/datasources/capture_data_source.dart';
import 'package:citizen_app/core/data/datasources/leaderboard_data_source.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton<HttpService>(() => HttpService());
  locator.registerLazySingleton<AiService>(() => AiService());
  locator.registerLazySingleton<DialogService>(() => DialogService());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<CampaignService>(() => CampaignService());
  locator.registerLazySingleton<NavService>(() => NavService());


  //use cases locator
  locator.registerLazySingleton<AuthDataSource>(() => AuthDataSource());
  locator.registerLazySingleton<LeaderboardDataSource>(() => LeaderboardDataSource());
  locator.registerLazySingleton<CampaignDataSource>(() => CampaignDataSource());
  locator.registerLazySingleton<CaptureDataSource>(() => CaptureDataSource());
  locator.registerLazySingleton<BadgeService>(() => BadgeService());
  locator.registerLazySingleton<ImageService>(() => ImageService());
  locator.registerLazySingleton<LocationService>(() => LocationService());
}