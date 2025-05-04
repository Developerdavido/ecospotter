import 'package:citizen_app/core/presentation/ui/views/badges/widget/card_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/media.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../data/models/badge_model.dart';
import '../../../../../data/models/user_badges_model.dart';
import '../../../../../view_models/badge_provider.dart';
import '../../../shared_widgets/default_loader.dart';
import '../../../shared_widgets/default_text.dart';
import '../../badges/badges_screen.dart';

class BuildBadgeWidget extends StatelessWidget {
  final String? userId;
  const BuildBadgeWidget({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    final badgeVm = Provider.of<BadgeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(Media.shield),
                const Gap(8),
                const DefaultText(
                  data: "Badges",
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  textColor: AppColors.mainPrimaryColor,
                  letterSpacing: -0.42,
                  lineHeight: 1.2,
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Get.to(() => const BadgesScreen());
              },
              child: const Text('See All'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        //this will show a list of the user earned badges
        SizedBox(
            height: 100,
            child: FutureBuilder<List<dynamic>>(
                future: Future.wait([badgeVm.getAllBadges(), badgeVm.getAllUserBadges(userId!)]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Loader());
                  }

                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Text('Failed to load user badges'));
                  }

                  final allBadges = snapshot.data![0] as List<BadgeModel>;
                  final userBadges = snapshot.data![1] as List<UserBadgeModel>;

                  //create a new list of earned badges
                  final List<BadgeModel> earnedBadges = [];
                  for (final userBadge in userBadges) {
                    final badge = allBadges.firstWhere((badge) => badge.id == userBadge.badgeId);
                    earnedBadges.add(badge);
                  }

                  if (earnedBadges.isEmpty) {
                    return const Center(child: Text('No badges earned yet'));
                  }

                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: earnedBadges.length,
                      itemBuilder: (context, index) {
                        final badge = earnedBadges[index];
                        return CardBadge(title: badge.name,assetPath: badge.iconUrl, color: Utils.getRandomMaterialColor());
                      });
                })),
      ],
    );
  }
}
