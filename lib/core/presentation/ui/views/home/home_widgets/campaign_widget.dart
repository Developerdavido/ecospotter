import 'package:cached_network_image/cached_network_image.dart';
import 'package:citizen_app/core/data/models/campaign_model.dart';
import 'package:citizen_app/core/presentation/ui/views/home/home_widgets/custom_campaign_tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../utils/utils.dart';
import '../../../shared_widgets/default_text.dart';


class CampaignWidget extends StatelessWidget {
  const CampaignWidget({super.key, this.model, this.onCardTap});
  final VoidCallback? onCardTap;
  final CampaignModel? model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: model?.status == 'ended' ? null : onCardTap!,
      child: Container(
        height: 260.h,
        width: 1.sw,
        decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(32.r),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(32.r),
              child: Hero(
                tag: model!.id,
                child: CachedNetworkImage(
                  imageUrl: model?.imageUrl ?? "",
                  height: 260.h,
                  width: 1.sw,
                  fit: BoxFit.cover,
                  errorWidget: (context, dto, widget) {
                    return Container(
                        height: 257.h,
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
            Positioned(
              top: 18.h,
              left: 16.w,
              child: CampaignTag(
                campaignTitle: model!.type,
                tag: model!.type == 'trivia' ? Icons.edit : CupertinoIcons.globe
              )
            ),
            Positioned(
                top: 58.h,
                left: 16.w,
                child: CampaignTag(
                    campaignTitle: model!.status,
                    tagColor: model!.status == 'ended' ? AppColors.red : AppColors.green,
                    tag: model!.status == 'ended' ? Icons.close : Icons.star_border_outlined
                )
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.6),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(32.r), bottomLeft: Radius.circular(32.r))
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        data: model?.title ?? "Bird Watch",
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
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
                )),
          ],
        ),
      )
    );
  }
}
