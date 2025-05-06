import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/media.dart';
import '../../../shared_widgets/default_text.dart';


class BadgeTriviaAndDescription extends StatelessWidget {
  final String? trivia;
  final String? description;
  final bool isExpanded;
  final String? errorMessage;
  const BadgeTriviaAndDescription({super.key, this.trivia, this.description, this.isExpanded = false, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(8.h),
          DefaultText(
            data: "Do You Know?",
            fontFamily: "Geist",
            fontWeight: FontWeight.w900,
            textColor: AppColors.mainPrimaryColor,
            fontSize: 28.sp,
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

          //if its expanded, show me this data
          if(isExpanded && errorMessage != null) ...[
            DefaultText(
              data: errorMessage ?? "Sorry this is not a type of animal we know about",
              fontFamily: "Geist",
              fontWeight: FontWeight.w400,
              textColor: AppColors.blackOA,
              fontSize: 16.sp,
              letterSpacing: -0.41,
              lineHeight: 1.33,
              textAlign: TextAlign.center,
            ).animate()
                .slide(
              begin: const Offset(0, -0.3),
              end: const Offset(0, 0), // End at center
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
          ],
          if(isExpanded && errorMessage == null) ...[
            Gap(12.h),
            DefaultText(
              data: description ?? "What do you think?",
              fontFamily: "Geist",
              fontWeight: FontWeight.w400,
              textColor: AppColors.blackOA,
              fontSize: 16.sp,
              letterSpacing: -0.41,
              lineHeight: 1.33,
              maxLines: 32,
              textAlign: TextAlign.center,
            ).animate()
                .slide(
              begin: const Offset(0, -0.3),
              end: const Offset(0, 0), // End at center
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
            Gap(16.h),
            DefaultText(
              data: "Fun Fact 🥳",
              fontFamily: "Geist",
              fontWeight: FontWeight.w900,
              textColor: AppColors.mainPrimaryColor,
              fontSize: 22.sp,
              letterSpacing: -0.41,
              lineHeight: 1.33,
              textAlign: TextAlign.center,
            ).animate()
                .slide(
              begin: const Offset(0, -0.3),
              end: const Offset(0, 0), // End at center
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
            Gap(12.h),
            DefaultText(
              data: trivia ?? "Interesting!!",
              fontFamily: "Geist",
              fontWeight: FontWeight.w400,
              textColor: AppColors.blackOA,
              fontSize: 16.sp,
              letterSpacing: -0.41,
              lineHeight: 1.33,
              maxLines: 15,
              textAlign: TextAlign.center,
            ).animate()
                .slide(
              begin: const Offset(0, -0.3),
              end: const Offset(0, 0), // End at center
              duration: 600.ms,
              curve: Curves.easeOutBack,
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Media.ai, height: 15.h, width: 15.w, colorFilter: const ColorFilter.mode(AppColors.mainPrimaryColor, BlendMode.srcIn),),
                Gap(5.w),
                DefaultText(
                  data: "Powered by Gemini AI Model",
                  fontFamily: "Geist",
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.mainPrimaryColor,
                  fontSize: 12.sp,
                  letterSpacing: -0.41,
                  lineHeight: 1.33,
                  textAlign: TextAlign.left,
                )
                    .animate(delay: 100.ms)
                    .slide(
                  begin: const Offset(0, -0.3),
                  end: const Offset(0, 0), // End at center
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                ).fade(begin: 0, end: 1, duration: 600.ms),
              ],
            ),
            Gap(10.h),
          ]
        ],
      ),
    );
  }
}
