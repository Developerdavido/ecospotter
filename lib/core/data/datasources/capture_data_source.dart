

import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../config/services/supabase_service.dart';
import '../../../constants/api.dart';

class CaptureDataSource {

  //get all captures based on campaign id
  //load all campaigns
  Future<List<Map<String, dynamic>>> loadAllPostsForCampaigns(
      {required String campaignId, required int currentPage, required int limit}) async {
    return await SupabaseService.supabase
        .from(ApiConstants.captures)
        .select()
        .eq('campaign_id', campaignId)
        .range(currentPage * limit, (currentPage + 1) * limit - 1)
        .order('captured_at', ascending: false);
  }

  //save the captured image


  //update the user avatar
  Future<String> uploadImage(String imagePath, String userId) async {
    //on complete, update the user data and fetch the user data again
    final imageFile = File(imagePath);
    //get the file extension
    final fileExt = path.extension(imageFile.path);
    final fileName = '${const Uuid().v4()}$fileExt';
    final String fullPath = await SupabaseService.supabase.storage.from('campaigns').upload(
      'conservation/$userId$fileName',
      imageFile,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
    );

    //fetch the public url
    String userImageResponse = await SupabaseService.supabase.storage
        .from('campaigns')
        .getPublicUrl('conservation/$userId$fileName');
    return userImageResponse;
  }

  //update the user details
  Future<List<Map<String, dynamic>>> saveANewCapture(Map<String, dynamic> captureData) async {
    return await SupabaseService.supabase
        .from(ApiConstants.captures)
        .insert(captureData)
        .select();
  }

}