import 'package:citizen_app/core/presentation/ui/views/welcome/welcome_widgets/dot_indicator_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants/app_colors.dart';


class IndicatorAndSkip extends StatelessWidget {
  const IndicatorAndSkip({super.key, required this.page, this.onTap});

  final int page;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DotIndicatorWidget(page: page, dotCount: 3),
          GestureDetector(
            onTap: onTap,
            child: Icon(
              CupertinoIcons.search,
              color: AppColors.primaryColor,
              size: 26.sp,
            ),
          )
        ],
      ),
    );
  }
}
