import 'package:cached_network_image/cached_network_image.dart';
import 'package:citizen_app/core/data/models/campaign_model.dart';
import 'package:citizen_app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants/app_colors.dart';
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
        height: 257.h,
        width: 1.sw,
        decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8.r),
        ),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: model?.imageUrl ?? "",
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
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.r), bottomLeft: Radius.circular(8.r))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultText(
                            data: model?.title ?? "Bird Watch",
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            textColor: AppColors.lime,
                            letterSpacing: -0.42,
                            lineHeight: 1.2,
                          ),
                          DefaultText(
                            data: "${Utils.fullDate(model?.startDate ?? DateTime.now())} - ${Utils.fullDate(model?.endDate ?? DateTime.now())}",
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            textColor: AppColors.white,
                            letterSpacing: -0.42,
                            lineHeight: 1.2,
                          ),
                        ],
                      ),
                      DefaultText(
                        data: model?.status.toUpperCase() ?? "on-going".toUpperCase(),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        textColor: model?.status == 'ended' ? AppColors.red : AppColors.green,
                        letterSpacing: -0.42,
                        lineHeight: 1.2,
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
