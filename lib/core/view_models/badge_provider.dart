

import 'dart:developer';

import 'package:citizen_app/core/data/models/user_badges_model.dart';
import 'package:citizen_app/core/view_models/base_provider.dart';
import 'package:dio/dio.dart';

import '../data/models/badge_model.dart';

class BadgeProvider extends BaseProvider {
  List<UserBadgeModel> userBadges = [];
  //get all badges
  Future<List<BadgeModel>> getAllBadges () async {
    List<BadgeModel> allBadges = [];
    try{
      var response = await badgeService.getAllBadges();
      log("All badges===>> ${response}");
      if(response.isNotEmpty) {
        allBadges = response.map((json) => BadgeModel.fromJson(json)).toList();
      }
      return allBadges;
    } on DioException catch (e) {
      print("Error loading all badges");
      return allBadges;
    }
  }

  //get the user badges
  Future<List<UserBadgeModel>> getAllUserBadges(String userId) async{
    try{
      var response = await badgeService.getUserBadges(userId);
      log("User badges===>> ${response}");
      if(response.isNotEmpty) {
        userBadges = response.map((json) => UserBadgeModel.fromJson(json)).toList();
      }
      return userBadges;
    } on DioException catch (e) {
      print("Error loading user badges: ${e.toString()}");
      return userBadges;
    }
  }
}