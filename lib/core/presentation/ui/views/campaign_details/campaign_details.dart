
import 'dart:ui';

import 'package:citizen_app/core/presentation/ui/views/campaign_details/campaign_details_widgets/campaign_app_bar.dart';
import 'package:citizen_app/core/presentation/ui/views/campaign_posts/campaign_posts.dart';
import 'package:citizen_app/core/presentation/ui/views/capture_form/capture_form.dart';
import 'package:citizen_app/core/view_models/campaign_view_model.dart';
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
import '../../../../../utils/utils.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_text.dart';


class CampaignDetails extends StatelessWidget {
  const CampaignDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CampaignProvider>(
      builder: (context, campaignVm, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.mainPrimaryColor,
            body: CustomScrollView(
              slivers: [
                CampaignDetailsAppBar(model: campaignVm.currentCampaign,),
                SliverGap(12.h),
                SliverFillRemaining(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AnimateList(
                        interval: 20.ms,
                        effects: [
                          SlideEffect(delay: 200.ms, begin: const Offset(0, 0.3), end: const Offset(0, 0)),
                          FadeEffect(duration: 300.ms),
                        ],
                        children: [
                        DefaultText(
                          data: "Description",
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          textColor: AppColors.lime,
                          letterSpacing: -0.42,
                          lineHeight: 1.2,
                        ),
                        Gap(8.h),
                        DefaultText(
                          data: campaignVm.currentCampaign!.description,
                          fontWeight: FontWeight.w300,
                          fontSize: 14.sp,
                          textColor: AppColors.white,
                          letterSpacing: -0.42,
                          maxLines: 10,
                          lineHeight: 1.6,
                        ),
                      ],)
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: SizedBox(
              width: 1.sw,
             height: 0.2.sh,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        Gap(20.h),
                        DefaultButton(
                            btnColor: AppColors.green5C,
                            btnTextColor: AppColors.mainBlack,
                            onBtnTap: (){
                              Get.to(()=> const CaptureForm(isHome: false,));
                            }, btnText: AppStrings.participate),
                        Gap(10.h),
                        DefaultButton(
                            btnColor: AppColors.white.withOpacity(0.1),
                            btnTextColor: AppColors.white,
                            onBtnTap: (){
                              Get.to(()=> const CampaignPosts());
                            }, btnText: AppStrings.viewPosts),
                        Gap(20.h),
                      ],
                    )
                  ),
                ),
              ),
            )
          ),
        );
      }
    );
  }
}
