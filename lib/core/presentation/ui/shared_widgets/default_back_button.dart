import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';



class DefaultBackButton extends StatelessWidget {
  const DefaultBackButton({super.key, this.onBackTap, this.iconColor, this.btnColor, this.icon});

  final VoidCallback? onBackTap;
  final IconData? icon;
  final Color? btnColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBackTap ?? (){
        Get.back();
      },
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
            color: btnColor ?? AppColors.ashColor,
            shape: BoxShape.circle
        ),
        child: Center(
          child: Icon(
            icon ?? CupertinoIcons.clear,
            color: iconColor ?? AppColors.white,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}