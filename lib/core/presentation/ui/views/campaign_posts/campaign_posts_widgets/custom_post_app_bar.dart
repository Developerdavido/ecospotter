import 'package:citizen_app/core/data/models/campaign_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../shared_widgets/default_back_button.dart';
import '../../../shared_widgets/default_text.dart';

class CustomPostAppBar extends StatelessWidget {
  const CustomPostAppBar({super.key, this.model});

  final CampaignModel? model;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0.18.sh,
      collapsedHeight: kToolbarHeight + 0.01.sh,
      backgroundColor: AppColors.mainPrimaryColor,
      pinned: true,
      floating: false,
      leading: DefaultBackButton(
        icon: Icons.chevron_left,
        btnColor: AppColors.mainPrimaryColor,
        iconColor: AppColors.white,
        onBackTap: () {
          Get.back();
        },
      ),
      title: DefaultText(
        data: "Posts",
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
        textColor: AppColors.white,
        letterSpacing: -0.42,
        lineHeight: 1.5,
      )
          .animate(delay: 100.ms)
          .slide(
        begin: const Offset(0.3, 0),
        end: const Offset(0, 0), // End at center
        duration: 600.ms,
        curve: Curves.easeOutBack,
      )
          .fade(begin: 0, end: 1, duration: 600.ms),
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Get the current height of the AppBar
          final double currentHeight = constraints.biggest.height;
          // Get the maximum height (expanded)
          final double maxHeight = MediaQuery.of(context).padding.top + 0.18.sh;

          // Calculate how expanded the app bar is (0.0 to 1.0)
          final double expandRatio = ((currentHeight - kToolbarHeight) /
              (maxHeight - kToolbarHeight)).clamp(0.0, 1.0);

          return FlexibleSpaceBar(
            background: Container(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
                top: kToolbarHeight + MediaQuery.of(context).padding.top,
              ),
              child: Opacity(
                // Fade out the text as the app bar collapses
                opacity: expandRatio,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(12.h),
                    DefaultText(
                      data: "Browse through pictures and posts from other users participating in this conservation campaign. See one you like! 😉",
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      textColor: AppColors.white,
                      maxLines: 6,
                      lineHeight: 1.2,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
