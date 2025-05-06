import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constants/app_colors.dart';


class LinearProgressBar extends StatelessWidget {
  const LinearProgressBar({super.key, this.progressValue = 0.0});

  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 5.h,
        width: 1.sw,
        child: LinearProgressIndicator(
          value: progressValue,
          backgroundColor: AppColors.borderColor,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.mainPrimaryColor),
          minHeight: 5.h,
          borderRadius: BorderRadius.circular(8.r),
        ).animate().fade());
  }
}
