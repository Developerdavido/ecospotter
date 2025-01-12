import 'package:citizen_app/core/presentation/ui/views/settings/settings_widgets/choose_image_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../constants/app_colors.dart';

class CustomPictureModal extends StatelessWidget {
  const CustomPictureModal({super.key, this.cameraBtnPressed, this.galleryBtnPressed});

  final VoidCallback?  cameraBtnPressed;
  final VoidCallback?  galleryBtnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.3.sh,
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 32.w),
      decoration: BoxDecoration(
          color: AppColors.bottomModal,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(32.r), topRight: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
              "Choose Profile photo",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.mainBlack
              )
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: cameraBtnPressed,
                child: const  ChooseImageIcon(
                  title: "Camera",
                  iconData: Icons.camera_alt_rounded,
                ),
              ),
              GestureDetector(
                onTap: galleryBtnPressed,
                child: const ChooseImageIcon(
                  title: "Gallery",
                  iconData: Icons.image,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
