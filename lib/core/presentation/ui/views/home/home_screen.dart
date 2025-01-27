import 'package:citizen_app/core/presentation/ui/shared_widgets/custom_shimmer.dart';
import 'package:citizen_app/core/presentation/ui/views/campaign_details/campaign_details.dart';
import 'package:citizen_app/core/presentation/ui/views/home/home_widgets/campaign_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/home/home_widgets/home_app_bar.dart';
import 'package:citizen_app/core/presentation/ui/views/profile/user_info_screen.dart';
import 'package:citizen_app/core/view_models/auth_provider.dart';
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
  AuthProvider? authVm;
  @override
  void initState() {
    // TODO: implement initState
    campaignVm = context.read<CampaignProvider>();
    authVm = context.read<AuthProvider>();
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
    campaignVm = context.watch<CampaignProvider>();
    authVm = context.watch<AuthProvider>();
    return Scaffold(
        backgroundColor: AppColors.mainPrimaryColor,
        body: CustomScrollView(
          slivers: [
            HomeAppBar(username: authVm!.userModel!.username),
            SliverGap(16.h),
            SliverFillRemaining(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: campaignVm!.loadingCampaigns
                    ? ListView(
                  children: List.generate(
                      6,
                          (index) => const CustomShimmerWidget(
                          type: ShimmerWidgetType.campaigns)),
                )
                    : campaignVm!.loadingError != null || campaignVm!.campaigns.isEmpty
                    ? Center(
                  child: Column(
                    children: [
                      DefaultText(
                        data: campaignVm?.loadingError ??
                            "No Campaigns currently available",
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
                )
                    : RefreshIndicator.adaptive(
                  onRefresh: () => campaignVm!.onRefresh(),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == campaignVm?.campaigns.length) {
                        if (campaignVm!.loadingCampaigns) {
                          return SizedBox(
                            height: 20.w,
                            width: 20.w,
                            child: const CircularProgressIndicator(
                              color: AppColors.lime,
                              strokeWidth: 0.8,
                            ),
                          );
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
                    itemCount: campaignVm!.campaigns.length,
                  ),
                ),
              ),
            ),
            SliverGap(70.h),
          ],
        ));
  }
}
