import 'package:citizen_app/core/constants/app_strings.dart';
import 'package:citizen_app/core/constants/media.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/custom_button.dart';
import 'package:citizen_app/core/presentation/ui/views/auth/views/login_screen.dart';
import 'package:citizen_app/core/presentation/ui/views/welcome/welcome_widgets/indicator_and_skip_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/welcome/welcome_widgets/onboarding_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  PageController pageController = PageController(initialPage: 0);
  int pageIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainPrimaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w,vertical: 0.04.sh),
        child: Column(
          children: [
            Gap(48.h),
            IndicatorAndSkip(
                page: pageIndex,
                onTap: (){
                  //TODO: skip and move to login screen
                }),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index){
                  setState(() {
                    pageIndex = index;
                  });
                },
                children: const [
                  OnBoardingPage(
                      title: AppStrings.page1Header,
                      subtitle: AppStrings.page1Message,
                      imagePath: Media.onboardingImageOne),
                  OnBoardingPage(
                      title: AppStrings.page2Header,
                      subtitle: AppStrings.page2Message,
                      imagePath: Media.onboardingImageTwo),
                  OnBoardingPage(
                      title: AppStrings.page3Header,
                      subtitle: AppStrings.page3Message,
                      imagePath: Media.onboardingImageThree)
                ],
              ),
            ),
            const Gap(16),
            DefaultButton(
              btnColor: AppColors.green5C,
                btnTextColor: AppColors.mainBlack,
                onBtnTap: (){
              Get.to(()=> const LoginScreen());
            }, btnText: AppStrings.continueBtn)
          ],
        ),
      ),
    );
  }
}
