import 'package:cached_network_image/cached_network_image.dart';
import 'package:citizen_app/core/data/models/capture_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../constants/app_colors.dart';
import '../../../shared_widgets/default_text.dart';




class ActivityWidget extends StatelessWidget {
  const ActivityWidget({super.key, this.model});

  final CaptureModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.9.sw,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: AppColors.borderColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32.w,
                width: 32.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.lime
                ),
                child: Center(
                  child: DefaultText(
                    data: model?.username.substring(0,1).toUpperCase() ?? "AN",
                    fontWeight: FontWeight.w700,
                    fontSize: 10.sp,
                    textColor: AppColors.mainBlack,
                    letterSpacing: -0.42,
                    lineHeight: 1.2,
                  ),
                ),
              ),
              Gap(6.w),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        data: "@${model?.username ?? "Anonymous"}",
                        fontFamily: "Geist",
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.white,
                        fontSize: 16.sp,
                        letterSpacing: -0.41,
                        lineHeight: 1.33,
                        textAlign: TextAlign.center,
                      ),
                      DefaultText(
                        data: "small description",
                        fontFamily: "Geist",
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.white,
                        fontSize: 12.sp,
                        letterSpacing: -0.41,
                        lineHeight: 1.33,
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                      Gap(8.h),
                      SizedBox(
                        height: 0.15.sh,
                        width: 0.9.sw,
                        child: CachedNetworkImage(
                          imageUrl: model?.imageUrl ?? "",
                          errorWidget: (context, dto, widget) {
                            return Container(
                              height: 0.15.sh,
                              width: 0.9.sw,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child:  Icon(
                                Icons.broken_image_outlined,
                                size: 32.sp,
                                color: AppColors.buttonBorder,
                              ),
                            );
                          },
                          imageBuilder: (context, imageProvider) => Container(
                            height: 0.15.sh,
                            width: 0.9.sw,
                            decoration: BoxDecoration(
                                color: AppColors.ashColor,
                                borderRadius: BorderRadius.circular(8.r),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter: const ColorFilter.mode(AppColors.ashColor, BlendMode.colorBurn)
                                )
                            ),
                          ),
                        ),
                      ),
                      Gap(4.h),
                      SizedBox(
                        height: 48.w,
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite_border_outlined,
                              color: AppColors.white,
                              size: 14.sp,
                            ),
                            Gap(4.w),
                            DefaultText(
                              data: "1K",
                              fontFamily: "Geist",
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.white,
                              fontSize: 14.sp,
                              letterSpacing: -0.41,
                              lineHeight: 1.33,
                              maxLines: 3,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))

            ],
          ),
        ],
      ),
    );
  }
}