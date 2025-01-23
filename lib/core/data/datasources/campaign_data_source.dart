import 'package:citizen_app/constants/api.dart';

import '../../../config/services/supabase_service.dart';

class CampaignDataSource {
  //load all campaigns
  Future<List<Map<String, dynamic>>> loadAllCampaigns(
      {required int currentPage, required int limit}) async {
    return await SupabaseService.supabase
        .from(ApiConstants.campaigns)
        .select()
        .range(currentPage * limit, (currentPage + 1) * limit - 1)
        .order('created_at', ascending: false);
  }
}
