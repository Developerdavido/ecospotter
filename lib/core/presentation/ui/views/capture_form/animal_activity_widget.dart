import 'package:citizen_app/core/presentation/ui/views/capture_form/current_image_campaign.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_text.dart';
import '../../shared_widgets/text_field.dart';


class AnimalActivity extends StatefulWidget {
  const AnimalActivity({super.key});

  @override
  State<AnimalActivity> createState() => _AnimalActivityState();
}

class _AnimalActivityState extends State<AnimalActivity> {
  final TextEditingController activityController = TextEditingController();
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
                  children: [
                    Gap(20.h),
                    DefaultText(
                      data: AppStrings.animalActivityTitle,
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
                      data: AppStrings.animalActivityMessage,
                      fontFamily: "Geist",
                      fontWeight: FontWeight.w400,
                      textColor: AppColors.white,
                      fontSize: 16.sp,
                      letterSpacing: -0.41,
                      lineHeight: 1.33,
                      textAlign: TextAlign.center,
                    ),
                    Gap(0.1.sh),
                    InputField(
                      controller: activityController,
                      title: "What was the animal doing?",
                      hintText: "Enter response here",
                      expandable: true,
                      validator: (value) {
                        if(value == null) {
                          return "animal activity input field must not be empty";
                        }
                        return null;
                      },
                    ),
                    Gap(40.h),
                    DefaultButton(
                        btnColor: AppColors.green5C,
                        btnTextColor: AppColors.blackOA,
                        onBtnTap: (){
                          Get.to(()=> const CurrentImageCampaign());
                        }, btnText: AppStrings.next),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
