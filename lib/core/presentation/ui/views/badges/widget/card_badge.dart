import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/media.dart';
import '../../../shared_widgets/default_text.dart';

class CardBadge extends StatelessWidget {
  final String title;
  final Color color;
  final String? assetPath;
  final String? earnedAt;
  final bool isEarned;
  final int? pointsRequired;
  final int? currentPoints;
  final bool showBadgeProgress;
  final double progress = 0.0;

  const CardBadge({super.key, required this.title, this.currentPoints, this.isEarned =  false, required this.color, this.assetPath, this.earnedAt, this.pointsRequired, this.showBadgeProgress = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: assetPath == null
                ? SvgPicture.asset(Media.trophy, colorFilter: ColorFilter.mode(color, BlendMode.srcIn), height: 10, width: 10, fit: BoxFit.contain,)
                : SvgPicture.network(assetPath ?? Media.trophy, colorFilter: ColorFilter.mode(color, BlendMode.srcIn), height: 10, width: 10, fit: BoxFit.contain,),
          ),
          const Gap(4),
          SizedBox(
            width: 70,
            child: DefaultText(
              data: title,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              maxLines: 2,
              textColor: AppColors.blackOA,
              letterSpacing: -0.42,
              textAlign: TextAlign.center,
              lineHeight: 1.2,
            ),
          ),
          const Gap(4),
          if(isEarned) DefaultText(
            data: "Earned on: ${earnedAt.toString().substring(0, 16)}",
            fontWeight: FontWeight.w400,
            fontSize: 10,
            maxLines: 1,
            textColor: AppColors.grey97,
            letterSpacing: -0.42,
            lineHeight: 1.2,
          ),

          if(showBadgeProgress && !isEarned) Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                data: "Required: $pointsRequired points",
                fontWeight: FontWeight.w400,
                fontSize: 10,
                maxLines: 1,
                textColor: AppColors.blackOA,
                letterSpacing: -0.42,
                lineHeight: 1.2,
              ),
              const Gap(4),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: AppColors.grey35.withValues(alpha: 0.3),
                valueColor: AlwaysStoppedAnimation<Color>(progress >= 1.0 ? AppColors.green : AppColors.mainPrimaryColor),
              ),
              const Gap(4),
              DefaultText(
                data: "Progress: $currentPoints/$pointsRequired points (${(progress * 100).toStringAsFixed(1)}%)",
                fontWeight: FontWeight.w400,
                fontSize: 10,
                maxLines: 1,
                textColor: progress >= 1.0 ? AppColors.green : AppColors.grey35,
                letterSpacing: -0.42,
                lineHeight: 1.2,
              ),
            ],
          )
        ],
      ),
    );
  }
}
