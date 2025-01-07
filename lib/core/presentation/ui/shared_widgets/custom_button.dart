import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../constants/app_colors.dart';
import 'default_text.dart';


class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {super.key,
        required this.onBtnTap,
        required this.btnText,
        this.btnColor,
        this.isNull = false,
        this.width,
        this.iconData,
        this.borderColor,
        this.btnTextColor,
        this.isIconPresent = false});

  final VoidCallback onBtnTap;
  final String btnText;
  final Color? btnColor;
  final Color? btnTextColor;
  final Color? borderColor;
  final double? width;
  final bool isNull;
  final String? iconData;
  final bool isIconPresent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBtnTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        width: 1.sw,
        height: 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.r),
            color: isNull ? AppColors.grey97 : btnColor ?? AppColors.white,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isIconPresent)
                SizedBox(height: 30.h, width: 30.h, child: SvgPicture.asset(iconData!)),
              Gap(12.w),
              DefaultText(data: btnText, textColor: btnTextColor, fontWeight: FontWeight.w500,)
            ],
          ),
        ),
      ),
    );
  }
}
