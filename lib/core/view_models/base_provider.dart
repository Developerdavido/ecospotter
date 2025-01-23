

import 'package:citizen_app/config/services/dialog_service.dart';
import 'package:citizen_app/config/services/image_service.dart';
import 'package:citizen_app/core/data/datasources/campaign_data_source.dart';
import 'package:citizen_app/core/data/datasources/capture_data_source.dart';
import 'package:citizen_app/core/data/datasources/leaderboard_data_source.dart';
import 'package:flutter/cupertino.dart';

import '../../config/locator.dart';
import '../data/datasources/auth/auth_data_source.dart';

enum UiState {loading, done , idle , error}

class BaseProvider with ChangeNotifier {


  var auth = locator<AuthDataSource>();
  var campaignData = locator<CampaignDataSource>();
  var leaderboardData = locator<LeaderboardDataSource>();
  var captureData = locator<CaptureDataSource>();
  var imageService = locator<ImageService>();
  var dialog = locator<DialogService>();

  UiState uiState = UiState.idle;

  //get loading state
  bool get isLoading => uiState == UiState.loading;
  //get error state
  bool get error => uiState == UiState.error;
  //get done state
  bool get done => uiState == UiState.done;



  //set ui state
  setUiState(UiState newState) {
    uiState = newState;
    notifyListeners();
  }

  //set the ui state without stating a fic
  updateUi(func) {
    func();
    notifyListeners();
  }

}