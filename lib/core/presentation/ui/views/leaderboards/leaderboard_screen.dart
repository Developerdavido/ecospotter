import 'package:citizen_app/core/presentation/ui/views/leaderboards/leaderboards_widget/leaderboard_ranking_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/leaderboards/leaderboards_widget/leaderboard_top_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../constants/app_colors.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_text.dart';


class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

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
            centerTitle: true,
            leading: DefaultBackButton(
              iconColor: AppColors.white,
              icon: CupertinoIcons.back,
              btnColor: AppColors.mainPrimaryColor.withOpacity(0.1),
            ),
            title:  DefaultText(
              data: "Leaderboards",
              fontWeight: FontWeight.w400,
              fontSize: 24.sp,
              textColor: AppColors.white,
              letterSpacing: -0.42,
              lineHeight: 1.2,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 0.45.sh,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              width: 1.sw,
              decoration: const BoxDecoration(
                color: Colors.transparent
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 18.h,
                      left: 0.06.sw,
                      child: const LeaderBoardTopWidget(position: 2, username: "kong32", points: 223,)),
                  Positioned(
                    bottom: 18.h,
                      right: 0.06.sw,
                      child: LeaderBoardTopWidget(position: 3, username: "xims22", points: 32,)),
                  Positioned(
                    top: 24.h,
                      left: 0,
                      right: 0,
                      child: LeaderBoardTopWidget(position: 1, username: "vada24", points: 1231,)),
                ],
              ),
            ),
          ),
          SliverGap(30.h),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
                  child: LeaderboardRanking(
                    username: "vada24",
                    imageUrl: null,
                    points: 1231,
                    position: "${index + 1}",
                  ),
                );
              },
              childCount: 20,
            ),
          ),
          SliverGap(0.1.sh)
        ],
      ),
    );
  }
}
