import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/app_colors.dart';
enum ShimmerWidgetType {campaigns, leaderboard, posts}
class CustomShimmerWidget extends StatelessWidget {
  final ShimmerWidgetType? type;

  const CustomShimmerWidget({
    super.key,
    @required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: Colors.grey.withOpacity(0.3),
      child: _buildType(context),
    );
  }

  Widget _buildType(context) {
    if (type == ShimmerWidgetType.campaigns) {
      return _buildHomeShimmer(context);
    }if(type == ShimmerWidgetType.leaderboard){
      return _buildLeaderboardShimmer(context);
    }if(type == ShimmerWidgetType.posts) {
      return _buildPostsShimmer(context);
    }else {
      return _buildHomeShimmer(context);
    }
    return Container();
  }

  Widget _buildHomeShimmer(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 257.h,
          width: 1.sw,
          decoration: BoxDecoration(
            color: AppColors.shimmerBaseColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        Gap(8.h),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 19.h,
                  width: 0.5.sw,
                  decoration: BoxDecoration(
                    color: AppColors.ashColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                Container(
                  height: 19.h,
                  width: 0.2.sw,
                  decoration: BoxDecoration(
                    color: AppColors.ashColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap(8.h),
        Container(
          height: 19.h,
          width: 0.7.sw,
          decoration: BoxDecoration(
            color: AppColors.ashColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardShimmer(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 19.h,
          width: 19.h,
          decoration: BoxDecoration(
            color: AppColors.ashColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        Gap(4.w),
        Container(
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColors.shimmerBaseColor,
            shape: BoxShape.circle,
          ),
        ),
        Gap(12.h),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 20.h,
                width: 0.4.sw,
                decoration: BoxDecoration(
                  color: AppColors.shimmerBaseColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              Container(
                height: 20.h,
                width: 0.2.sw,
                decoration: BoxDecoration(
                  color: AppColors.ashColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostsShimmer(context) {
    return Container(
      width: 0.9.sw,
      height: 0.25.sh,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 32.w,
                width: 32.w,
                decoration:const BoxDecoration(
                  color: AppColors.shimmerBaseColor,
                  shape: BoxShape.circle
                ),
              ),
            ],
          ),
          Gap(6.w),
          Expanded(
              child: Column(
                children: [
                  Container(
                    height: 19.h,
                    width: 0.6.sw,
                    decoration: BoxDecoration(
                      color: AppColors.ashColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  Gap(4.h),
                  Container(
                    height: 19.h,
                    width: 0.6.sw,
                    decoration: BoxDecoration(
                      color: AppColors.ashColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  Gap(8.h),
                  Container(
                    height: 0.15.sh,
                    width: 0.9.sw,
                    decoration: BoxDecoration(
                      color: AppColors.ashColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

}