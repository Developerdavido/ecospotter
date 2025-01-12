import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/media.dart';
import '../../../shared_widgets/default_text.dart';


class LeaderboardRanking extends StatelessWidget {
  const LeaderboardRanking({super.key, this.username, this.imageUrl, this.points, this.position});

  final String? position;
  final String? username;
  final String? imageUrl;
  final int? points;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 22.w),
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.r),
              color: AppColors.white.withOpacity(0.1)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50.h,
                      width: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.r),
                        image: DecorationImage(
                          image: imageUrl == null
                              ? AssetImage(Media.profile, )
                              : NetworkImage(imageUrl!) as ImageProvider,
                            fit: BoxFit.contain
                        )
                      ),
                    ),
                    Gap(16.w),
                    DefaultText(
                      data: "@$username",
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      textColor: AppColors.white,
                      letterSpacing: -0.42,
                      lineHeight: 1.2,
                    ),
                  ],
                ),
                DefaultText(
                  data: "$points",
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  textColor: AppColors.darkGreen,
                  letterSpacing: -0.42,
                  lineHeight: 1.2,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
