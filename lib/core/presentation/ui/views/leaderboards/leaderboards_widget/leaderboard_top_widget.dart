import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/media.dart';
import '../../../shared_widgets/default_text.dart';

class LeaderBoardTopWidget extends StatelessWidget {
  const LeaderBoardTopWidget(
      {super.key, this.position, this.imageUrl, this.username, this.points});

  final int? position;
  final String? imageUrl;
  final String? username;
  final int? points;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DefaultText(
          data: "$position",
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          fontFamily: "Orpheus Pro",
          textColor: AppColors.white,
          letterSpacing: -0.42,
          lineHeight: 1.2,
        ),
        Gap(6.h),
        position == 1
            ? Image.asset(
                Media.crown,
                height: 48.h,
                width: 48.w,
                fit: BoxFit.contain,
              )
                .animate(delay: 800.ms)
                .scale(
                  begin: const Offset(0.9, 0.9),
                  end: const Offset(1, 1), // End at center
                  duration: 600.ms,
                  curve: Curves.easeOutBack,
                )
                .fade(begin: 0, end: 1, duration: 600.ms)
            : Container(),
        Gap(12.h),
        Container(
          height: position == 1 ? 140.h : 110.h,
          width: position == 1 ? 140.h : 110.h,
          decoration: ShapeDecoration(
              shape:
                  const CircleBorder(side: BorderSide(color: AppColors.lime, width: 1.5)),
              image: DecorationImage(
                  image: imageUrl == null
                      ? AssetImage(
                          Media.profile,
                        )
                      : NetworkImage(imageUrl!) as ImageProvider,
                  fit: BoxFit.contain),
              shadows: position == 1
                  ? [
                      const BoxShadow(
                        color: AppColors.lime,
                        blurRadius: 16,
                        spreadRadius: 1,
                      )
                    ]
                  : null),
        ),
        Gap(12.h),
        DefaultText(
          data: "@${username ?? "anon"}",
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          textColor: AppColors.white,
          letterSpacing: -0.42,
          lineHeight: 1.2,
        ),
        DefaultText(
          data: "${points ?? 0}",
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
          textColor: AppColors.darkGreen,
          letterSpacing: -0.42,
          lineHeight: 1.2,
        ),
      ],
    );
  }
}
