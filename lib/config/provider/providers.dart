import 'package:citizen_app/core/view_models/ai_provider.dart';
import 'package:citizen_app/core/view_models/auth_provider.dart';
import 'package:citizen_app/core/view_models/campaign_view_model.dart';
import 'package:citizen_app/core/view_models/leaderboard_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../core/view_models/badge_provider.dart';
import '../../core/view_models/capture_provider.dart';



List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
  ChangeNotifierProvider<AIVm>.value(value: AIVm()),
  ChangeNotifierProvider<CampaignProvider>.value(value: CampaignProvider()),
  ChangeNotifierProvider<BadgeProvider>.value(value: BadgeProvider()),
  ChangeNotifierProvider<CaptureProvider>.value(value: CaptureProvider()),
  ChangeNotifierProvider<LeaderboardProvider>.value(value: LeaderboardProvider()),
];

void resetAllProviders(BuildContext context) {
  Provider.of<AuthProvider>(context).dispose();
  Provider.of<CampaignProvider>(context).dispose();
  Provider.of<CaptureProvider>(context).dispose();
  Provider.of<LeaderboardProvider>(context).dispose();
}