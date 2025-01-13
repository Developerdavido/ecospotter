import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../constants/app_colors.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_text.dart';
import '../home/home_widgets/activity_widget.dart';

class CampaignPosts extends StatefulWidget {
  const CampaignPosts({super.key});

  @override
  State<CampaignPosts> createState() => _CampaignPostsState();
}

class _CampaignPostsState extends State<CampaignPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainPrimaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: AppColors.mainPrimaryColor,
            elevation: 0,
            surfaceTintColor: AppColors.mainPrimaryColor,
            leading: const DefaultBackButton(
              iconColor: AppColors.white,
              icon: CupertinoIcons.back,
              btnColor: AppColors.mainPrimaryColor,
            ),
            title:  DefaultText(
              data: "Bird Watch Posts",
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
              textColor: AppColors.white,
              letterSpacing: -0.42,
              lineHeight: 1.2,
            ).animate(delay: 100.ms)
                .slide(
              begin: const Offset(0.3, 0),
              end: const Offset(0, 0), // End at center
              duration: 600.ms,
              curve: Curves.easeOutBack,
            )
                .fade(begin: 0, end: 1, duration: 600.ms),
            expandedHeight: 0.1.sh,
          ),
          SliverGap(12.h),
          SliverList.builder(
            itemCount: 20,
             itemBuilder: (BuildContext context, int index) {
              return const ActivityWidget(
                model: null,
              ).animate()
                  .slide(
                begin: const Offset(0, 0.3),
                end: const Offset(0, 0), // End at center
                duration: 600.ms + index.ms,
                curve: Curves.easeOutBack,
              )
                  .fade(begin: 0, end: 1, duration: 600.ms);
          },
          ),
        ],
      ),
    );
  }
}
