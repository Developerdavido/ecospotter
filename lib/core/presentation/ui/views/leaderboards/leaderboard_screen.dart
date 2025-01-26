import 'package:citizen_app/constants/app_strings.dart';
import 'package:citizen_app/core/presentation/ui/views/leaderboards/leaderboards_widget/leaderboard_ranking_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/leaderboards/leaderboards_widget/leaderboard_top_three_positions.dart';
import 'package:citizen_app/core/presentation/ui/views/leaderboards/leaderboards_widget/leaderboard_top_widget.dart';
import 'package:citizen_app/core/view_models/leaderboard_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../view_models/campaign_view_model.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/custom_shimmer.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_text.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  ScrollController scrollController = ScrollController();
  LeaderboardProvider? leaderboardVm;
  @override
  void initState() {
    // TODO: implement initState
    leaderboardVm = context.read<LeaderboardProvider>();
    scrollController.addListener(_scrollFunction);
    leaderboardVm?.getAllLeaderboards();
    super.initState();
  }

  void _scrollFunction() {
    if (scrollController.position.maxScrollExtent - scrollController.position.pixels <=
        150.h) {
      leaderboardVm?.getAllLeaderboards();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollFunction);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    leaderboardVm = context.watch<LeaderboardProvider>();
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
            title: DefaultText(
              data: "Leaderboards",
              fontWeight: FontWeight.w400,
              fontSize: 24.sp,
              textColor: AppColors.white,
              letterSpacing: -0.42,
              lineHeight: 1.2,
            )
                .animate(delay: 100.ms)
                .slide(
                  begin: const Offset(0.3, 0),
                  end: const Offset(0, 0), // End at center
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                )
                .fade(begin: 0, end: 1, duration: 600.ms),
          ),
          SliverGap(12.h),
          SliverToBoxAdapter(
              child: leaderboardVm!.leaderboards.length < 3
                  ? const SizedBox.shrink()
                  : LeaderTopThreePositions(
                      leaderboards: leaderboardVm!.leaderboards,
                    )),
          SliverGap(30.h),
          SliverFillRemaining(
            child: leaderboardVm!.loadingLeaderboards
                ? ListView(
                    children: List.generate(
                        6,
                        (index) => const CustomShimmerWidget(
                            type: ShimmerWidgetType.leaderboard)),
                  )
                : leaderboardVm!.loadingError != null ||
                        leaderboardVm!.leaderboards.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            DefaultText(
                              data: leaderboardVm?.loadingError ??
                                  "No users on the leaderboard yet.",
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              textColor: AppColors.white,
                              letterSpacing: -0.42,
                              lineHeight: 1.2,
                              textAlign: TextAlign.center,
                            ),
                            DefaultButton(
                                btnColor: Colors.transparent,
                                btnTextColor: AppColors.white,
                                onBtnTap: () {
                                  leaderboardVm?.onRefresh();
                                },
                                btnText: AppStrings.retry),
                          ],
                        ),
                      )
                    : RefreshIndicator.adaptive(
                        onRefresh: () => leaderboardVm!.onRefresh(),
                        child: ListView.builder(
                          itemCount: leaderboardVm!.leaderboards.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == leaderboardVm?.leaderboards.length) {
                              if (leaderboardVm!.loadingLeaderboards) {
                                return SizedBox(
                                  height: 20.w,
                                  width: 20.w,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.lime,
                                    strokeWidth: 0.8,
                                  ),
                                );
                              }
                              if (!leaderboardVm!.hasMore) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: DefaultText(
                                      data: "No more users to show for this leaderboard",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp,
                                      textColor: AppColors.white,
                                      letterSpacing: -0.42,
                                      lineHeight: 1.2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }
                            final leaderboard = leaderboardVm?.leaderboards[index];
                            return Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
                              child: LeaderboardRanking(
                                username: leaderboard!.username,
                                imageUrl: leaderboard.avatar,
                                points: leaderboard.points,
                                position: "${index + 1}",
                              ),
                            )
                                .animate()
                                .slide(
                                  begin: const Offset(0, 0.3),
                                  end: const Offset(0, 0), // End at center
                                  duration: 600.ms + index.ms,
                                  curve: Curves.easeOutBack,
                                )
                                .fade(begin: 0, end: 1, duration: 600.ms);
                          },
                        ),
                      ),
          ),
          SliverGap(0.1.sh)
        ],
      ),
    );
  }
}
