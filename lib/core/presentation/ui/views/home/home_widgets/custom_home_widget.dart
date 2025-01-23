import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/app_strings.dart';
import '../../../shared_widgets/default_text.dart';


class CustomHomeTiles extends StatelessWidget {
  const CustomHomeTiles(
      {super.key,
        required this.customWidgetHeight,
        required this.widget,
        this.onBtnTap,
        required this.tileTitle,
        this.showTitle = true,
        this.isBtnPresent = true});
  final double customWidgetHeight;
  final VoidCallback? onBtnTap;
  final Widget widget;
  final String tileTitle;
  final bool showTitle;
  final bool isBtnPresent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showTitle ? DefaultText(
              data: tileTitle,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              textColor: AppColors.greyE3,
              letterSpacing: -0.42,
              lineHeight: 1.2,
            ) : Container(),
            isBtnPresent
                ? InkWell(
              onTap: onBtnTap,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                height: 32.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.r),
                    color: AppColors.grey35,
                    border: Border.all(color: AppColors.buttonBorder, width: 0.5)),
                child: Center(
                    child: DefaultText(
                      data: AppStrings.viewAll,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      textColor: AppColors.white,
                      letterSpacing: -0.36,
                      lineHeight: 1.2,
                    )),
              ),
            )
                : Container()
          ],
        ),
        Gap(8.h),
        SizedBox(
          height: customWidgetHeight,
          width: 1.sw,
          child: widget,
        )
      ],
    );
  }
}