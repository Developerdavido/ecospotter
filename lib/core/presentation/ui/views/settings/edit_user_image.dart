import 'package:citizen_app/core/presentation/ui/views/settings/settings_widgets/custom_picture_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../config/locator.dart';
import '../../../../config/services/dialog_service.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_text.dart';
import '../capture_form/capture_widgets/capture_image.dart';


class EditUserImage extends StatelessWidget {
  const EditUserImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainPrimaryColor,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
                floating: false,
                pinned: true,
                backgroundColor: AppColors.mainPrimaryColor,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                leading:  DefaultBackButton(
                  iconColor: AppColors.white,
                  icon: CupertinoIcons.back,
                  btnColor: AppColors.mainPrimaryColor,
                )
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  children: AnimateList(
                    interval: 20.ms,
                    effects: [
                      SlideEffect(delay: 200.ms, begin: const Offset(0, 0.3), end: const Offset(0, 0)),
                      FadeEffect(duration: 300.ms),
                    ],
                    children: [
                      Gap(20.h),
                      DefaultText(
                        data: AppStrings.avatarTitle,
                        fontFamily: "Geist",
                        fontWeight: FontWeight.w900,
                        textColor: AppColors.lime,
                        fontSize: 20.sp,
                        letterSpacing: -0.41,
                        lineHeight: 1.33,
                        textAlign: TextAlign.center,
                      ),
                      Gap(4.h),
                      DefaultText(
                        data: AppStrings.avatarMessage,
                        fontFamily: "Geist",
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.white,
                        fontSize: 16.sp,
                        letterSpacing: -0.41,
                        lineHeight: 1.33,
                        textAlign: TextAlign.center,
                      ),
                      Gap(0.1.sh),
                      CaptureImage(
                        onImageTap: (){
                          locator<DialogService>().showCustomModal(context: context, customModal: CustomPictureModal(
                            cameraBtnPressed: (){
                              Get.back();
                            },
                            galleryBtnPressed: (){
                              Get.back();
                            },
                          ));
                        },
                        imagePath: null,
                      ),
                      Gap(12.h),
                      DefaultText(
                        data: AppStrings.captureAvatar,
                        fontFamily: "Geist",
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.green,
                        fontSize: 12.sp,
                        letterSpacing: -0.41,
                        lineHeight: 1.33,
                        textAlign: TextAlign.center,
                      ),
                      Gap(44.h),
                      DefaultButton(
                          btnColor: AppColors.green5C,
                          btnTextColor: AppColors.mainBlack,
                          onBtnTap: (){
                            Get.back();
                          }, btnText: AppStrings.submit),
                    ],
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
