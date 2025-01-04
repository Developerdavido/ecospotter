import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../constants/app_colors.dart';


class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.title, required this.imagePath, required this.subtitle});

  final String imagePath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 1.sw,
          height: 340.h,
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ).animate().scale(duration: 1000.ms,),
        Gap(10.h),
        SizedBox(
          width: 290.w,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.blackOA,
              fontSize: 32.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
            ),
          ),
        ).animate().fadeIn().slideY(begin: 4, delay: 1000.ms, duration: 1000.ms),
        Gap(26.h),
        SizedBox(
          width: 267.w,
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.blackOA,
              fontSize: 14.sp,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w500,
            ),
          ),
        ).animate().fadeIn().slideY(begin: 4, delay: 1200.ms, duration: 1000.ms)
      ],
    );
  }
}
