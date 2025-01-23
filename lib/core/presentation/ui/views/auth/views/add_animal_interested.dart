
import 'package:citizen_app/core/view_models/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:provider/provider.dart';

import '../../../../../../config/locator.dart';
import '../../../../../../config/services/dialog_service.dart';
import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/app_strings.dart';
import '../../../../../../utils/utils.dart';
import '../../../shared_widgets/custom_app_bar.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/default_loader.dart';
import '../../../shared_widgets/default_text.dart';
import '../../app_navigation/app_navigation_screen.dart';

class AnimalInterestedScreen extends StatefulWidget {
  const AnimalInterestedScreen({super.key});

  @override
  State<AnimalInterestedScreen> createState() => _AnimalInterestedScreenState();
}

class _AnimalInterestedScreenState extends State<AnimalInterestedScreen> {
  List<String> selectedAnimals = [];
  @override
  Widget build(BuildContext context) {
    final authVm = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainPrimaryColor,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(20.h),
                const CustomLoginAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Gap(20.h),
                          DefaultText(
                            data: AppStrings.preferenceTitle,
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
                            data: AppStrings.preferenceMessage,
                            fontFamily: "Geist",
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.white,
                            fontSize: 16.sp,
                            letterSpacing: -0.41,
                            lineHeight: 1.33,
                            maxLines: 4,
                            textAlign: TextAlign.center,
                          ).animate()
                              .slide(
                            begin: const Offset(0, -0.3),
                            end: const Offset(0, 0), // End at center
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
                          )
                              .fade(begin: 0, end: 1, duration: 600.ms),
                          Gap(40.h),
                          Wrap(
                            spacing: 15.w,
                            runSpacing: 15.h,
                            children: List.generate(Utils.animals.length,
                                (index) {
                              var animal = Utils.animals[index];
                              return ChoiceChip(
                                label: DefaultText(
                                  data: animal,
                                  fontFamily: "Geist",
                                  fontWeight: FontWeight.w400,
                                  textColor: AppColors.mainBlack,
                                  fontSize: 16.sp,
                                  letterSpacing: -0.41,
                                  lineHeight: 1.33,
                                  maxLines: 4,
                                  textAlign: TextAlign.center,
                                ),
                                selected: selectedAnimals.contains(animal),
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.r)
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 12.h),
                                backgroundColor: AppColors.bottomModal.withOpacity(0.4),
                                selectedColor: AppColors.bottomModal,
                                onSelected: (selected) {
                                  setState(() {
                                    if(selected == false) {
                                      selectedAnimals.remove(animal);
                                    }else {
                                      selectedAnimals.add(animal);
                                    }
                                  });
                                },
                              ).animate()
                                  .slide(
                                begin: const Offset(0.3, 0),
                                end: const Offset(0, 0), // End at center
                                duration: 600.ms,
                                curve: Curves.easeOutBack,
                              )
                                  .fade(begin: 0, end: 1, duration: 600.ms);
                            }),
                          ),
                          Gap(40.h),
                          DefaultButton(
                            isNull: selectedAnimals.isEmpty,
                            onBtnTap: () async {
                              if(selectedAnimals.isEmpty) {
                                locator<DialogService>().showSnackBar("Error", "At least one animal must be selected before proceeding");
                                return;
                              }
                              authVm.animalsInterested.addAll(selectedAnimals);
                              await authVm.saveUserInDb();
                            },
                            btnText: AppStrings.submit,
                            isIconPresent: false,
                            btnColor: AppColors.green5C,
                            btnTextColor: AppColors.mainBlack,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: authVm.isLoading || authVm.loading,
              child: const Loader(),
            )
          ],
        ),
      ),
    );
  }
}
