import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: AppColors.white,
            elevation: 0,
            surfaceTintColor: AppColors.white,
            leading: const DefaultBackButton(
              iconColor: AppColors.blackOA,
              icon: CupertinoIcons.back,
              btnColor: AppColors.white,
            ),
            title:  DefaultText(
              data: "Bird Watch Posts",
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
              textColor: AppColors.blackOA,
              letterSpacing: -0.42,
              lineHeight: 1.2,
            ),
            expandedHeight: 0.1.sh,
          ),
          SliverGap(12.h),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return const ActivityWidget(
                  model: null,
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
