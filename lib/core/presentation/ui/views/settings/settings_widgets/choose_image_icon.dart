import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../../../constants/app_colors.dart';
import '../../../shared_widgets/default_text.dart';


class ChooseImageIcon extends StatelessWidget {
  const ChooseImageIcon({super.key, this.iconData, this.title});

  final IconData? iconData;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 68.h,
          width: 68.h,
          padding: EdgeInsets.all(12.w),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color:  AppColors.primaryColor
          ),
          child:  Center(
            child: Icon(
              iconData,
              color: AppColors.white,
              size: 24.sp,
            ),
          ),
        ).animate()
        .slide(
      begin: const Offset(0, -0.2), // Start from top of screen
      end: const Offset(0, 0), // End at center
      duration: 500.ms,
      curve: Curves.easeOutBack,
    )
        .fade(begin: 0, end: 1, duration: 500.ms),
        Gap(6.h),
        DefaultText(
          data: title ?? "",
          fontWeight: FontWeight.w500,
          fontSize: 18.sp,
          textColor: AppColors.mainBlack,
          letterSpacing: -0.42,
          lineHeight: 1.2,
        ).animate()
        .slide(
    begin: const Offset(0, -0.2), // Start from top of screen
    end: const Offset(0, 0), // End at center
    duration: 500.ms,
    curve: Curves.easeOutBack,
    )
        .fade(begin: 0, end: 1, duration: 500.ms, delay: 200.ms),
      ],
    );
  }
}
