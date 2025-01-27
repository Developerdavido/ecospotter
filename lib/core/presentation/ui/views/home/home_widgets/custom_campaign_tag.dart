import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../shared_widgets/default_text.dart';

class CampaignTag extends StatelessWidget {
  const CampaignTag({super.key, this.campaignTitle, this.tag, this.tagColor});

  final String? campaignTitle;
  final IconData? tag;
  final Color? tagColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.white, width: 0.5),
        color: AppColors.primaryColor.withOpacity(0.5),
      ),
      child: Row(
        children: [
          Icon(
            tag ?? CupertinoIcons.eye,
            color: AppColors.white,
            size: 14.sp,
          ),
          Gap(4.w),
          DefaultText(
            data: campaignTitle ?? "Campaign",
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            textColor: tagColor ?? AppColors.white,
            letterSpacing: -0.42,
            lineHeight: 1.2,
          ),
        ],
      ),
    );
  }
}
