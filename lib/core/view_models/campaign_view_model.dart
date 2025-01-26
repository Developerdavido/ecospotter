import 'package:citizen_app/core/view_models/base_provider.dart';
import 'package:get/get.dart';

import '../data/models/campaign_model.dart';

class CampaignProvider extends BaseProvider {
  List<CampaignModel> campaigns = [];

  CampaignModel? currentCampaign;

  int currentPage = 0;
  int limit = 30;
  bool hasMore = true;
  bool loadingCampaigns = false;
  String? loadingError;
  //get all campaigns
  getAllCampaigns() async {
    //if loading campaigns is true || the data does not have more then return
    if (loadingCampaigns || !hasMore) return;
    try {
      loadingCampaigns = true;
      List<Map<String, dynamic>> loadedCampaigns =
          await campaignData.loadAllCampaigns(currentPage: currentPage, limit: limit);
      if(loadedCampaigns.isEmpty){
        hasMore = false;
      }else {
        campaigns = loadedCampaigns.map((e) => CampaignModel.fromJson(e)).toList();
        currentPage++;
      }
      loadingError = null;
      updateUi(()=> loadingCampaigns = false);
    } on Exception catch (e) {
      updateUi(()=> loadingCampaigns = false);
      dialog.showSnackBar("Error", e.toString());
      loadingError = "Cannot load campaigns now, please try again";
    }
  }

  Future<void> onRefresh(){
    campaigns.clear();
    hasMore = true;
    currentPage = 0;
    loadingError = null;
   return  getAllCampaigns();

  }


  setCurrentCampaign(CampaignModel model){
    currentCampaign = model;
    notifyListeners();
  }
}
