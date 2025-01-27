

import 'dart:developer';

import 'package:citizen_app/core/data/models/ranking_model.dart';
import 'package:citizen_app/core/view_models/base_provider.dart';

class LeaderboardProvider extends BaseProvider {


  List<LeaderboardModel> leaderboards = [];

  int currentPage = 0;
  int limit = 30;
  bool hasMore = true;
  bool loadingLeaderboards = false;
  String? loadingError;
  //get all campaigns
  getAllLeaderboards() async {
    //if loading campaigns is true || the data does not have more then return
    log(loadingLeaderboards.toString());
    if (loadingLeaderboards || !hasMore) return;
    try {
      loadingLeaderboards = true;
      List<Map<String, dynamic>> loadedLeaderboards =
      await leaderboardData.loadAllLeaderboards(currentPage: currentPage, limit: limit);
      log(loadingLeaderboards.toString());
      if(loadedLeaderboards.isEmpty){
        hasMore = false;
      }else {
        leaderboards = loadedLeaderboards.map((e) => LeaderboardModel.fromJson(e)).toList();
        leaderboards.sort((a,b)=> a.points!.compareTo(b.points!));
        leaderboards.reversed;
        currentPage++;
      }
      loadingError = null;
      updateUi(()=> loadingLeaderboards = false);
    } on Exception catch (e) {
      updateUi(()=> loadingLeaderboards = false);
      dialog.showSnackBar("Error", e.toString());
      loadingError = "Cannot load leaderboards now, please try again";
    }
  }

  Future<void> onRefresh(){
    leaderboards.clear();
    hasMore = true;
    currentPage = 0;
    loadingError = null;
    return getAllLeaderboards();
  }


}