import 'package:citizen_app/core/view_models/campaign_view_model.dart';
import 'package:citizen_app/core/view_models/capture_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/custom_shimmer.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_text.dart';
import '../home/home_widgets/activity_widget.dart';

class CampaignPosts extends StatefulWidget {
  const CampaignPosts({super.key});

  @override
  State<CampaignPosts> createState() => _CampaignPostsState();
}

class _CampaignPostsState extends State<CampaignPosts> {
  ScrollController scrollController = ScrollController();
  CampaignProvider? campaignVm;
  CaptureProvider? captureVm;
  @override
  void initState() {
    // TODO: implement initState
    campaignVm = context.read<CampaignProvider>();
    captureVm = context.read<CaptureProvider>();
    scrollController.addListener(_scrollFunction);
    captureVm?.getAllCapturesForCampaign(campaignVm!.currentCampaign!.id);
    super.initState();
  }

  void _scrollFunction() {
    if (scrollController.position.maxScrollExtent - scrollController.position.pixels <=
        150.h) {
      captureVm?.getAllCapturesForCampaign(campaignVm!.currentCampaign!.id);
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollFunction);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    captureVm = context.watch<CaptureProvider>();
    campaignVm = context.watch<CampaignProvider>();
    return Scaffold(
      backgroundColor: AppColors.mainPrimaryColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
              child: DefaultText(
                data: "${campaignVm!.currentCampaign!.title} \nPosts",
                fontWeight: FontWeight.w700,
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
          ),
          SliverGap(12.h),
          SliverFillRemaining(
            child: captureVm!.loadingCaptures
                ? ListView(
                    children: List.generate(
                        6,
                        (index) =>
                            const CustomShimmerWidget(type: ShimmerWidgetType.posts)),
                  )
                : captureVm!.loadingError != null || campaignVm!.campaigns.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            DefaultText(
                              data: captureVm?.loadingError ??
                                  "No posts available for this campaign",
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
                                  captureVm?.onRefresh(campaignVm!.currentCampaign!.id);
                                },
                                btnText: AppStrings.retry),
                          ],
                        ),
                      )
                    : RefreshIndicator.adaptive(
                        onRefresh: () =>
                            captureVm!.onRefresh(campaignVm!.currentCampaign!.id),
                        child: ListView.builder(
                          itemCount: captureVm!.captures.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == captureVm?.captures.length) {
                              if (captureVm!.loadingCaptures) {
                                return SizedBox(
                                  height: 20.w,
                                  width: 20.w,
                                  child: const CircularProgressIndicator(
                                    color: AppColors.lime,
                                    strokeWidth: 0.8,
                                  ),
                                );
                              }
                              if (!captureVm!.hasMore) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: DefaultText(
                                      data: "No more posts for this campaign",
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
                            var post = captureVm?.captures[index];
                            return ActivityWidget(
                              model: post,
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
          )
        ],
      ),
    );
  }
}
