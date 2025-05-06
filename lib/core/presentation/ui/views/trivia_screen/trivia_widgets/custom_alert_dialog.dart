import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/app_strings.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/default_text.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? message;
  const CustomAlertDialog({super.key, this.title, this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      elevation: 4,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.white
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultText(
              data: title ?? "Success",
              fontFamily: "Geist",
              fontWeight: FontWeight.w900,
              textColor: AppColors.mainPrimaryColor,
              fontSize: 20.sp,
              letterSpacing: -0.41,
              lineHeight: 1.33,
              textAlign: TextAlign.center,
            ).animate(delay: 100.ms)
                .slide(
              begin: const Offset(0, -0.3),
              end: const Offset(0, 0), // End at center
              duration: 600.ms,
              curve: Curves.easeOutBack,
            )
                .fade(begin: 0, end: 1, duration: 600.ms),
            Gap(4.h),
            DefaultText(
              data: message ?? "",
              fontFamily: "Geist",
              fontWeight: FontWeight.w400,
              textColor: AppColors.blackOA,
              fontSize: 16.sp,
              letterSpacing: -0.41,
              lineHeight: 1.33,
              maxLines: 20,
              textAlign: TextAlign.center,
            ).animate()
                .slide(
              begin: const Offset(0, -0.3),
              end: const Offset(0, 0), // End at center
              duration: 600.ms,
              curve: Curves.easeOutBack,
            )
                .fade(begin: 0, end: 1, duration: 600.ms),
            Gap(0.03.sh),
            DefaultButton(
                btnColor: AppColors.mainPrimaryColor,
                btnTextColor: AppColors.white,
                onBtnTap: (){
                  Get.back();
                }, btnText: AppStrings.ok),
          ],
        ),
      )
    );
  }
}
