import 'dart:convert';

import 'package:citizen_app/config/services/local_storage_service.dart';
import 'package:citizen_app/config/services/supabase_service.dart';
import 'package:flutter/material.dart';

import '../models/badge_model.dart';

class BadgeService {
  // get all the available badges from supabase
  Future<List<Map<String, dynamic>>> getAllBadges() async {
    final response = await SupabaseService.supabase.from('badges').select();
    return response;
  }

  //get the user earned badges from supabase
  Future<List<Map<String, dynamic>>> getUserBadges(String userId) async {
    final response = await SupabaseService.supabase.from('user_badges').select().eq('user_id', userId);
    return response;
  }

  //check and award badges
  Future<List<BadgeModel>> checkAndAwardBadges(String userId, int currentPoints) async {

    //get all the badges
    final badges = await getAllBadges();

    //get the user earned badges
    final userBadges = await getUserBadges(userId);
    final earnedBadgeIds = userBadges.map((e) => e['badge_id']).toSet();

    //find badges that can be awarded based on points
    final List<Map<String, dynamic>> newlyEarnedBadges = [];

    for (final badge in badges) {
      if(!earnedBadgeIds.contains(badge['id']) && currentPoints >= badge['points_required']){
        await awardBadge(userId, badge['id']);
        newlyEarnedBadges.add(badge);
      }
    }

    //save the newly earned badges to local storage for offline access
    List<BadgeModel> newlyEarnedBadgeModels = [];
    if(newlyEarnedBadges.isNotEmpty){
      newlyEarnedBadgeModels = newlyEarnedBadges.map((e) => BadgeModel.fromJson(e)).toList();
      await saveNewBadgesToLocal(userId, newlyEarnedBadgeModels);
    }
    return newlyEarnedBadgeModels;
  }

  //award a new badge to the user
  Future<void> awardBadge(String userId, String badgeId) async {
    final now = DateTime.now();
    await SupabaseService.supabase.from('user_badges').insert({
      'user_id': userId,
      'badge_id': badgeId,
      'earned_at': now.toIso8601String(),
      'is_viewed': false,
    });
  }

  //save the badges to local
  Future<void> saveNewBadgesToLocal(String userId, List<BadgeModel> newBadges) async {
    //get the existing local badges or create empty list
    final localBadges = await CacheHelper.instance.readModel('user_badges_$userId') ?? "[]";
    final List<dynamic> localBadgesList = json.decode(localBadges);

    //add new badges with current timestamp
    final now = DateTime.now().toIso8601String();
    for (final badge in newBadges) {
      localBadgesList.add({
        'badge_id': badge.id,
        'earned_at': now,
        'is_viewed': false,
      });
    }
    //save the updated local badges list
    await CacheHelper.instance.cacheModel('user_badges_$userId', localBadgesList);
  }

  //Mark a badge as viewed
  Future<void> markBadgeAsViewed(String userId, String badgeId) async {
    //update in supabase
    await SupabaseService.supabase.from("user_badges").update({'is_viewed': true}).eq('user_id', userId).eq('badge_id', badgeId);

    //update the badge locally
    final localBadges = await CacheHelper.instance.readModel('user_badges_$userId') ?? "[]";
    final List<dynamic> localBadgesList = json.decode(localBadges);

    for (final badge in localBadgesList) {
      if (badge['badge_id'] == badgeId) {
        badge['is_viewed'] = true;
        break;
      }
    }
    await CacheHelper.instance.cacheModel('user_badges_$userId', localBadgesList);
  }

  //get all the unviewed badges for notifications
  Future<List<Map<String, dynamic>>> getUnviewedBadges(String userId) async {
    //first check local storage
    final localBadges = await CacheHelper.instance.readModel('user_badges_$userId') ?? "[]";
    final List<dynamic> localBadgesList = json.decode(localBadges);

    //filter the unviewed badges
    final unviewedBadges = localBadgesList.where((badge) => !badge['is_viewed']).toList();

    //get the badge details for the unviewed badges
    final List<Map<String, dynamic>> badgeDetails = [];

    if(unviewedBadges.isNotEmpty) {
      // get all badges for reference
      final allBadges = await getAllBadges();

      for (final badge in unviewedBadges) {
        final badgeDetail = allBadges.firstWhere((b) => b['id'] == badge['badge_id']);

        badgeDetails.add({
          'badge': badgeDetail,
          'earned_at': DateTime.parse(badge['earned_at'])
        });
      }
    }
    return badgeDetails;
  }

  //Sync local badges with server when connection is available
  Future<void> syncBadgesWithServer(String userId) async {
    try{
      final localBadgesJson = await CacheHelper.instance.readModel('user_badges_$userId') ?? "[]";
      final List<dynamic> localBadgesList = json.decode(localBadgesJson);

      //get server badges
      final response = await SupabaseService.supabase.from('user_badges').select().eq('user_id', userId);

      if(response.isNotEmpty) {
        final serverBadges = response.map((e) => e['badge_id']).toSet();

        //find badges that exist locally but not on server
        final List<Map<String, dynamic>> badgesToSync = [];

        for (var localBadge in localBadgesList){
          final badgeId = localBadge['badge_id'];
          if(!serverBadges.contains(badgeId)){
            badgesToSync.add({
              'user_id': userId,
              'badge_id':badgeId,
              'earned_at': localBadge['earned_at'],
              'is_viewed': localBadge['is_viewed'],
            });
          }
        }

        //upload new badges to server
        if(badgesToSync.isNotEmpty){
          await SupabaseService.supabase.from('user_badges').insert(badgesToSync);
        }
      }

    } catch (e) {
      print("Error syncing badges: $e");
    }
  }

  //update user points
  Future<void> updateUserPoints(String userId, int additionalPoints) async {
    final response = await SupabaseService.supabase.from('profiles').select('points').eq('id', userId);
    if (response.isNotEmpty) {
      final points = response[0]['points'] as int;
      await SupabaseService.supabase.from('profiles').update({'points': points + additionalPoints}).eq('id', userId);

      //check and award badges locally
      final newlyEarnedBadges = await checkAndAwardBadges(userId, additionalPoints);

      //show notification for new badges
      if(newlyEarnedBadges.isNotEmpty){
        for(final badge in newlyEarnedBadges) {
          //TODO: show a notification when a new badge has been added
          print("New badge earned: ${badge.name}");
        }
      }
    }
  }
}
