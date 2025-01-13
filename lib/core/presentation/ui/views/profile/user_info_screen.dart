import 'package:citizen_app/core/presentation/ui/views/profile/profile_widgets/profile_top.dart';
import 'package:citizen_app/core/presentation/ui/views/profile/profile_widgets/user_profile_element.dart';
import 'package:citizen_app/core/presentation/ui/views/settings/edit_user_image.dart';
import 'package:citizen_app/core/presentation/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_text.dart';


class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainPrimaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: AppColors.mainPrimaryColor,
            elevation: 0,
            surfaceTintColor: AppColors.mainPrimaryColor,
            centerTitle: true,
            leading: DefaultBackButton(
              iconColor: AppColors.white,
              icon: CupertinoIcons.back,
              btnColor: AppColors.mainPrimaryColor.withOpacity(0.1),
            ),
            title:  DefaultText(
              data: "Profile",
              fontWeight: FontWeight.w400,
              fontSize: 24.sp,
              textColor: AppColors.white,
              letterSpacing: -0.42,
              lineHeight: 1.2,
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(12.h),
                  const ProfileTop(avatar: null, username: null, email: null,),
                  Expanded(
                      child: Column(
                        children: AnimateList(interval: 20.ms, effects: [
                          FadeEffect(duration: 300.ms),
                          SlideEffect(delay: 200.ms, begin: const Offset(0, -0.2), end: const Offset(0, 0))
                        ], children: [
                          Gap(22.h),
                          UserProfileElement(
                              iconData: Icons.edit,
                              title: "Edit avatar",
                              callback: () {
                               Get.to(()=> const EditUserImage());
                              }),
                          Gap(22.h),
                          UserProfileElement(
                              iconData: Icons.history_rounded,
                              title: "History",
                              callback: () {
                                //Get.to(() => const BookmarkedEvents());
                              }),
                          Gap(22.h),
                          // UserProfileElement(
                          //     iconData: Icons.history_rounded,
                          //     title: "Tickets History",
                          //     callback: () {
                          //       //Get.to(()=> const UserTickets());
                          //     }),
                          // Gap(22.h),
                          UserProfileElement(
                              iconData: Icons.help_outline,
                              title: "Help and support",
                              callback: () {}),
                          Gap(44.h),
                          DefaultButton(
                              btnColor: Colors.transparent,
                              btnTextColor: AppColors.red,
                              btnFontWeight: FontWeight.w600,
                              onBtnTap: (){
                                Get.offAll(()=> const WelcomeScreen());
                              }, btnText: AppStrings.logout),
                        ]),
                      ))
                ],
              ),
            ),
            ),
        ],
      ),
    );
  }
}
