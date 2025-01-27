import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../data/models/campaign_model.dart';
import '../../../shared_widgets/default_back_button.dart';
import '../../../shared_widgets/default_text.dart';
import '../../home/home_widgets/custom_campaign_tag.dart';



class CampaignDetailsAppBar extends StatelessWidget {
  const CampaignDetailsAppBar({super.key, this.model});

  final CampaignModel? model;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0.45.sh, // Increased height for better image display
      pinned: true,
      floating: false,
      backgroundColor: AppColors.mainPrimaryColor, // Make base AppBar transparent
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double currentHeight = constraints.biggest.height;
          final double maxHeight = MediaQuery.of(context).padding.top + 0.45.sh;

          // Calculate expansion ratio
          final double expandRatio = ((currentHeight - kToolbarHeight) /
              (maxHeight - kToolbarHeight)).clamp(0.0, 1.0);

          return FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Background image with fade effect
                Opacity(
                  opacity: expandRatio,
                  child: Hero(
                    tag: model!.id,
                    child: CachedNetworkImage(
                      imageUrl: model?.imageUrl ?? "",
                      height: 0.4.sh,
                      width: 1.sw,
                      fit: BoxFit.cover,
                      errorWidget: (context, dto, widget) {
                        return Container(
                          height: 0.4.sh,
                          width: 1.sw,
                          decoration: BoxDecoration(
                            color: AppColors.mainPrimaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              size: 32.sp,
                              color: AppColors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Gradient overlay to ensure text readability
                Opacity(
                  opacity: expandRatio,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.mainPrimaryColor.withOpacity(0.0),
                          AppColors.mainPrimaryColor.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),
                // Content that fades with expansion
                Positioned(
                  left: 0.w,
                  right: 0.w,
                  bottom: 0.0.h,
                  child: Opacity(
                    opacity: expandRatio,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  CampaignTag(
                                      campaignTitle: model!.type,
                                      tag: model!.type == 'trivia' ? Icons.edit : CupertinoIcons.globe
                                  ),
                                  Gap(8.w),
                                  CampaignTag(
                                      campaignTitle: model!.status,
                                      tagColor: model!.status == 'ended' ? AppColors.red : AppColors.green,
                                      tag: model!.status == 'ended' ? Icons.close : Icons.star_border_outlined
                                  )
                                ],
                              ),
                              Gap(8.h),
                              DefaultText(
                                data: model?.title ?? "Bird Watch",
                                fontWeight: FontWeight.w600,
                                fontSize: 22.sp,
                                textColor: AppColors.lime,
                                letterSpacing: -0.42,
                                lineHeight: 1.2,
                              ),
                              Gap(8.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_outlined,
                                    color: AppColors.white,
                                    size: 16.sp,
                                  ),
                                  Gap(4.w),
                                  DefaultText(
                                    data: "${Utils.fullDate(model?.startDate ?? DateTime.now())} - ${Utils.fullDate(model?.endDate ?? DateTime.now())}",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp,
                                    textColor: AppColors.white,
                                    letterSpacing: -0.42,
                                    lineHeight: 1.2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // Leading icon - stays visible
      leading: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: DefaultBackButton(
          icon: Icons.chevron_left,
          btnColor: AppColors.white,
          iconColor: AppColors.mainPrimaryColor,
          onBackTap: () {
            Get.back();
          },
        ),
      ),
      // Action icons - stay visible
      actions: [
        Padding(
          padding: EdgeInsets.all(8.0.w),
          child:const  DefaultBackButton(
            icon: Icons.info_outline,
            btnColor: AppColors.white,
            iconColor: AppColors.mainPrimaryColor,
          ),
        ),
      ],
    );
  }
}
