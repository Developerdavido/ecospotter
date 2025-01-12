import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants/app_colors.dart';


class DotIndicatorWidget extends StatelessWidget {
  const DotIndicatorWidget({super.key, required this.page, required this.dotCount});

  final int page;
  final int dotCount;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: dotCount == 0 ? 1 : dotCount,
      position: page,
      mainAxisAlignment: MainAxisAlignment.center,
      decorator: DotsDecorator(
          color: AppColors.white,
          size: Size.square(8.0.w),
          activeSize: Size(18.0.w, 8.h),
          activeColor: AppColors.lime,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          )),
    );
  }
}
