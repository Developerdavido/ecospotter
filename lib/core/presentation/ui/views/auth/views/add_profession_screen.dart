import 'package:citizen_app/core/config/locator.dart';
import 'package:citizen_app/core/config/services/auth_service.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/dropdown_btn.dart';
import 'package:citizen_app/core/presentation/ui/views/auth/views/add_animal_interested.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../constants/media.dart';
import '../../../shared_widgets/custom_app_bar.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/default_text.dart';



class AddProfessionScreen extends StatefulWidget {
  const AddProfessionScreen({super.key});

  @override
  State<AddProfessionScreen> createState() => _AddProfessionScreenState();
}

class _AddProfessionScreenState extends State<AddProfessionScreen> {

  final TextEditingController genderController = TextEditingController();
  final TextEditingController? professionController = TextEditingController();

  String? chosenGender;
  String? chosenProfession;

  @override
  Widget build(BuildContext context) {
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
                            data: AppStrings.professionTitle,
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
                            data: AppStrings.professionMessage,
                            fontFamily: "Geist",
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.white,
                            fontSize: 16.sp,
                            letterSpacing: -0.41,
                            lineHeight: 1.33,
                            textAlign: TextAlign.center,
                          ),
                          Gap(20.h),
                          DropdownBtn(
                              controller: genderController,
                            title: "Gender",
                            height: 0.3.sh,
                            hintText: "Select gender",
                            labelText: chosenGender,
                            items: locator<AuthService>().gender,
                            onChanged: (gender){
                                setState(() {
                                  chosenGender = gender;
                                });
                            },
                          ),
                          Gap(20.h),
                          DropdownBtn(
                            controller: genderController,
                            title: "Profession",
                            height: 0.6.sh,
                            hintText: "Select profession",
                            labelText: chosenProfession,
                            items: locator<AuthService>().professions,
                            onChanged: (profession){
                              setState(() {
                                chosenProfession = profession;
                              });
                            },
                          ),
                          Gap(40.h),
                          DefaultButton(
                            onBtnTap: () async {
                              // var success  = await authVm.loginUser(AuthMethod.google);
                              // if(success){
                              Get.to(() => const AnimalInterestedScreen(),
                                  transition: Transition.cupertino);
                              // }
                            },
                            btnText: AppStrings.next,
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
            // Visibility(
            //   visible: authVm.isLoading,
            //   child: const Loader(),
            // )
          ],
        ),
      ),
    );
  }
}
