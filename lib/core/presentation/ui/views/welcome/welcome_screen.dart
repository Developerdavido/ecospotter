import 'package:citizen_app/core/constants/app_strings.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/custom_button.dart';
import 'package:citizen_app/core/presentation/ui/views/welcome/welcome_widgets/indicator_and_skip_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/welcome/welcome_widgets/onboarding_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
      backgroundColor: AppColor.white,
      body: Column(
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
                    title: 'Discover a wide array of events',
                    subtitle: 'List of music event show ideas that you might find interesting',
                    imagePath: 'assets/images/onboarding_one.png'),
                OnBoardingPage(
                    title: 'More than just an event finder',
                    subtitle: 'List of music event show ideas that you might find interesting',
                    imagePath: 'assets/images/onboarding_two.png'),
                OnBoardingPage(
                    title: "It's your gateway to the world's events",
                    subtitle: 'List of music event show ideas that you might find interesting',
                    imagePath: 'assets/images/onboarding_three.png')
              ],
            ),
          ),
          const Gap(16),
          DefaultButton(onBtnTap: (){}, btnText: AppString.continueBtn)
        ],
      ),
    );
  }
}
