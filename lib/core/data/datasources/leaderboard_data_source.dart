

import '../../../config/services/supabase_service.dart';
import '../../../constants/api.dart';

class LeaderboardDataSource {


  //create leaderboard data  for user
  Future<List<Map<String, dynamic>>> insertUser(Map<String, dynamic> data) async {
    return await SupabaseService.supabase
        .from(ApiConstants.leaderboard)
        .insert(data);
  }
  //load all leaderboards
  Future<List<Map<String, dynamic>>> loadAllLeaderboards({required int currentPage, required int limit}) async {
    return await SupabaseService.supabase
        .from(ApiConstants.leaderboard)
        .select()
        .range(currentPage * limit, (currentPage + 1) * limit - 1)
        .order('created_at', ascending: false);
  }
  //update leaderboard data for user
  Future<List<Map<String, dynamic>>> updateUser(String userId, Map<String, dynamic> data) async {
    return await SupabaseService.supabase
        .from(ApiConstants.leaderboard)
        .update(data).eq("id", userId);
  }
}