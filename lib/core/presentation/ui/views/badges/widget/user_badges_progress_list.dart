
import 'dart:developer';

import 'package:citizen_app/core/data/models/badge_model.dart';
import 'package:citizen_app/core/data/models/user_badges_model.dart';
import 'package:citizen_app/core/presentation/ui/views/badges/widget/card_badge.dart';
import 'package:citizen_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../view_models/badge_provider.dart';
import '../../../shared_widgets/default_loader.dart';


class UserBadgesProgressList extends StatelessWidget {
  final String userId;
  final int points;
  const UserBadgesProgressList({super.key, required this.userId, required this.points});

  @override
  Widget build(BuildContext context) {
    final badgeVm = Provider.of<BadgeProvider>(context);
    return FutureBuilder(
        future: Future.wait([
          badgeVm.getAllBadges(),
          badgeVm.getAllUserBadges(userId),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Loader());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Failed to load user badges ${snapshot.error.toString()}'));
          }

          final allBadges = snapshot.data![0] as List<BadgeModel>;
          final userBadges = snapshot.data![1] as List<UserBadgeModel>;

          log(allBadges.toString());
          // Create a map of badgeId to earned timestamp
          final Map<String, DateTime> earnedBadgesMap = {};
          for (final userBadge in userBadges) {
            earnedBadgesMap[userBadge.badgeId] = userBadge.earnedAt;
          }

          // Sort badges by points required
          allBadges.sort((a, b) => a.pointsRequired.compareTo(b.pointsRequired));

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: allBadges.length,
                itemBuilder: (context, index) {
                  final badge = allBadges[index];
                  final isEarned = earnedBadgesMap.containsKey(badge.id);
                  final earnedDate = earnedBadgesMap[badge.id];
                  return CardBadge(
                    title: badge.name,
                    color: Utils.getRandomMaterialColor(),
                    isEarned: isEarned,
                    currentPoints: points,
                    pointsRequired: badge.pointsRequired,
                    assetPath: badge.iconUrl,
                    showBadgeProgress: true,
                    earnedAt: earnedDate.toString(),
                  );
                })
          );
        });
  }
}
