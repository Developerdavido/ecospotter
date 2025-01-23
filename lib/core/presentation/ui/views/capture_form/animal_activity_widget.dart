import 'package:citizen_app/core/presentation/ui/views/capture_form/current_image_campaign.dart';
import 'package:citizen_app/core/view_models/capture_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
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
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CaptureProvider>(
        builder: (context, vm, _) {
          return Scaffold(
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
                    child: Form(
                      key: _key,
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
                          ).animate(delay: 100.ms)
                              .slide(
                            begin: const Offset(0, -0.3),
                            end: const Offset(0, 0), // End at center
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
                          )
                              .fade(begin: 0, end: 1, duration: 600.ms),
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
                          ).animate()
                              .slide(
                            begin: const Offset(0, -0.3),
                            end: const Offset(0, 0), // End at center
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
                          )
                              .fade(begin: 0, end: 1, duration: 600.ms),
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
                          ).animate()
                              .slide(
                            begin: const Offset(0, 0.3),
                            end: const Offset(0, 0), // End at center
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
                          )
                              .fade(begin: 0, end: 1, duration: 500.ms),
                          Gap(40.h),
                          DefaultButton(
                              btnColor: AppColors.green5C,
                              btnTextColor: AppColors.blackOA,
                              onBtnTap: (){
                                if(_key.currentState!.validate()) {
                                  vm.animalActivity = activityController.text.trim();
                                  Get.to(()=> const CurrentImageCampaign());
                                }
                              }, btnText: AppStrings.next),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
