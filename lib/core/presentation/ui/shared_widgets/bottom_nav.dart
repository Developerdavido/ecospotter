import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/services/navigation_service.dart';
import '../../../constants/app_colors.dart';


class BottomNav extends StatelessWidget {
  final int? currentIndex;
  final void Function(int)? getCurrentIndex;
  const BottomNav({super.key, this.currentIndex, this.getCurrentIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 68.h,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            height: 99.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
                border: const Border(top: BorderSide(color: AppColors.buttonBorder, width: 0.3)),
                color: AppColors.white.withOpacity(0.1)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  3, (index) {
                var navigatorItem = NavService.navigationItems(isSelected: currentIndex == index)[index];
                return GestureDetector(
                  onTap: () {
                    getCurrentIndex!(index);
                  },
                  child: navigatorItem,
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}