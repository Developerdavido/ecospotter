import 'package:citizen_app/constants/app_strings.dart';
import 'package:citizen_app/core/presentation/ui/views/leaderboards/leaderboards_widget/leaderboard_ranking_widget.dart';
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

  void _scrollFunction(){
    if(scrollController.position.maxScrollExtent - scrollController.position.pixels <= 150.h){
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
          SliverToBoxAdapter(
            child: Container(
              height: 0.45.sh,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              width: 1.sw,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 18.h,
                      left: 0.06.sw,
                      child: LeaderBoardTopWidget(
                        position: 2,
                        username: leaderboardVm!.leaderboards[1].username,
                        points: leaderboardVm!.leaderboards[1].points,
                      ).animate()
                          .slide(
                        begin: const Offset(-0.4, 0),
                        end: const Offset(0, 0), // End at center
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                      )
                          .fade(begin: 0, end: 1, duration: 600.ms),),
                  Positioned(
                      bottom: 18.h,
                      right: 0.06.sw,
                      child: LeaderBoardTopWidget(
                        position: 3,
                        username: leaderboardVm!.leaderboards[2].username,
                        points: leaderboardVm!.leaderboards[2].points,
                      ).animate()
                          .slide(
                        begin: const Offset(0.4, 0),
                        end: const Offset(0, 0), // End at center
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                      )
                          .fade(begin: 0, end: 1, duration: 600.ms),),
                  Positioned(
                      top: 24.h,
                      left: 0,
                      right: 0,
                      child: LeaderBoardTopWidget(
                        position: 1,
                        username: leaderboardVm!.leaderboards[0].username,
                        points: leaderboardVm!.leaderboards[0].points,
                      ).animate()
                          .slide(
                        begin: const Offset(0, -0.4),
                        end: const Offset(0, 0), // End at center
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                      )
                          .fade(begin: 0, end: 1, duration: 600.ms),),
                ],
              ),
            ),
          ),
          SliverGap(30.h),
          ListenableBuilder(
            listenable: leaderboardVm!,
            builder: (context, child) {
              if (leaderboardVm!.loadingError != null && leaderboardVm!.leaderboards.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        DefaultText(
                          data: leaderboardVm!.loadingError!,
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
                  ),
                );
              }
              return RefreshIndicator.adaptive(
                onRefresh: leaderboardVm!.onRefresh(),
                child: SliverList.builder(
                  itemCount: leaderboardVm!.loadingLeaderboards ? 8 :leaderboardVm!.leaderboards.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == leaderboardVm?.leaderboards.length) {
                      if (leaderboardVm!.loadingLeaderboards) {
                        return const CustomShimmerWidget(
                            type: ShimmerWidgetType.leaderboard);
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
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
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
              );
            }
          ),
          SliverGap(0.1.sh)
        ],
      ),
    );
  }
}
