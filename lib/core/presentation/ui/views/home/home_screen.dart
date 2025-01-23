import 'package:citizen_app/core/presentation/ui/shared_widgets/custom_shimmer.dart';
import 'package:citizen_app/core/presentation/ui/views/campaign_details/campaign_details.dart';
import 'package:citizen_app/core/presentation/ui/views/home/home_widgets/campaign_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/profile/user_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../constants/media.dart';
import '../../../../view_models/campaign_view_model.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController = ScrollController();
  CampaignProvider? campaignVm;
  @override
  void initState() {
    // TODO: implement initState
    campaignVm = context.read<CampaignProvider>();
    scrollController.addListener(_scrollFunction);
    campaignVm?.getAllCampaigns();
    super.initState();
  }

  void _scrollFunction() {
    if (scrollController.position.maxScrollExtent - scrollController.position.pixels <=
        150.h) {
      campaignVm?.getAllCampaigns();
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollFunction);
    super.dispose();
  }

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
            surfaceTintColor: Colors.transparent,
            leading: Image.asset(
              Media.appIcon,
              height: 40.h,
              width: 0.6.sw,
            ),
            actions: [
              Row(
                children: [
                  DefaultBackButton(
                    icon: CupertinoIcons.person,
                    btnColor: AppColors.mainPrimaryColor,
                    onBackTap: () {
                      Get.to(() => const UserProfileScreen());
                    },
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  // const DefaultBackButton(
                  //   icon: CupertinoIcons.bell,
                  // ),
                  SizedBox(
                    width: 8.w,
                  ),
                ],
              )
            ],
          ),
          SliverGap(12.h),
          // SliverToBoxAdapter(
          //   child:  Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          //     child: DefaultText(
          //       data: "Welcome \nanon12345",
          //       fontFamily: "Geist",
          //       fontWeight: FontWeight.w600,
          //       textColor: AppColors.white,
          //       fontSize: 48.sp,
          //       letterSpacing: -0.41,
          //       lineHeight: 1.33,
          //       textAlign: TextAlign.left,
          //     ).animate(delay: 100.ms)
          //         .slide(
          //       begin: const Offset(0.3, 0),
          //       end: const Offset(0, 0), // End at center
          //       duration: 600.ms,
          //       curve: Curves.easeOutBack,
          //     )
          //         .fade(begin: 0, end: 1, duration: 600.ms),
          //   ),
          // ),
          //SliverGap(0.05.sh),
          ListenableBuilder(
            builder: (context, child) {
              if (campaignVm!.loadingError != null && campaignVm!.campaigns.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      children: [
                        DefaultText(
                          data: campaignVm!.loadingError!,
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
                              campaignVm?.onRefresh();
                            },
                            btnText: AppStrings.retry),
                      ],
                    ),
                  ),
                );
              }
              return RefreshIndicator.adaptive(
                onRefresh: campaignVm?.onRefresh(),
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index == campaignVm?.campaigns.length) {
                        if (campaignVm!.loadingCampaigns) {
                          return const CustomShimmerWidget(
                              type: ShimmerWidgetType.campaigns);
                        }
                        if (!campaignVm!.hasMore) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: DefaultText(
                                data: "No more campaigns",
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
                      final campaign = campaignVm?.campaigns[index];
                      return CampaignWidget(
                        model: campaign,
                        onCardTap: () {
                          campaignVm!.setCurrentCampaign(campaign!);
                          Get.to(() => const CampaignDetails());
                        },
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
                    childCount: campaignVm!.loadingCampaigns ? 4 :campaignVm!.campaigns.length + 1,
                  ),
                ),
              );
            },
            listenable: campaignVm!,
          ),
          SliverGap(70.h),
        ],
      ),
    );
  }
}
