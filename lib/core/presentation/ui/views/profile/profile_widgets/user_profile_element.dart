import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../../../constants/app_colors.dart';
import '../../../shared_widgets/default_text.dart';


class UserProfileElement extends StatelessWidget {
  const UserProfileElement({super.key, this.callback, this.iconData, this.title});

  final VoidCallback? callback;
  final IconData? iconData;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.r),
          color: AppColors.white.withOpacity(0.1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              iconData,
              color: AppColors.green,
              size: 22.sp,
            ),
            Gap(20.w),
            DefaultText(
              data: title ?? "",
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              textColor: AppColors.white,
              letterSpacing: -0.42,
              lineHeight: 1.2,
            ),
          ],
        ),
      ),
    );
  }
}
