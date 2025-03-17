import 'package:cached_network_image/cached_network_image.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/default_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../shared_widgets/default_text.dart';


class SpeciesInfo extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final String? description;
  const SpeciesInfo({super.key, this.title, this.imageUrl, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: AppColors.bottomModal,
      ),
      height: 0.75.sh,
      width: 1.sw,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultBackButton(
            onBackTap: () {
              Get.back();
            },
          ),
          Gap(20.h),
          DefaultText(
            data: "Here is some Information about $title",
            fontFamily: "Geist",
            fontWeight: FontWeight.w700,
            textColor: AppColors.blackOA,
            fontSize: 18.sp,
            letterSpacing: -0.41,
            lineHeight: 1.3,
            textAlign: TextAlign.left,
          ),
          Gap(20.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(32.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? "",
              height: 0.15.sh,
              width: 1.sw,
              fit: BoxFit.cover,
              errorWidget: (context, dto, widget) {
                return Container(
                  height: 0.15.sh,
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
          Expanded(
              child: DefaultText(
                data: description ?? "",
                fontWeight: FontWeight.w300,
                fontSize: 14.sp,
                textColor: AppColors.blackOA,
                letterSpacing: -0.42,
                maxLines: 10,
                lineHeight: 1.6,
              ),),
          //Gap(0.15.sh)
        ],
      ),
    );
  }
}
