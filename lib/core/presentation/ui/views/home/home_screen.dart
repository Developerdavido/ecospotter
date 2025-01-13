import 'package:citizen_app/core/constants/app_colors.dart';
import 'package:citizen_app/core/presentation/ui/views/campaign_details/campaign_details.dart';
import 'package:citizen_app/core/presentation/ui/views/home/home_widgets/activity_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/home/home_widgets/campaign_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/profile/user_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../constants/app_strings.dart';
import '../../../../constants/media.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_text.dart';
import 'home_widgets/custom_home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            surfaceTintColor: Colors.transparent,
            leading:  Image.asset(
              Media.appIcon,
              height: 40.h,
              width: 0.6.sw,
            ),
            actions: [
              Row(
                children: [
                  DefaultBackButton(
                    icon: CupertinoIcons.person,
                    btnColor: AppColors.mainPrimaryColor,
                    onBackTap: (){
                      Get.to(()=> const UserProfileScreen());
                    },
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  // const DefaultBackButton(
                  //   icon: CupertinoIcons.bell,
                  // ),
                  SizedBox(
                    width: 8.w,
                  ),
                ],
              )
            ],
          ),
          SliverGap(12.h),
          // SliverToBoxAdapter(
          //   child:  Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          //     child: DefaultText(
          //       data: "Welcome \nanon12345",
          //       fontFamily: "Geist",
          //       fontWeight: FontWeight.w600,
          //       textColor: AppColors.white,
          //       fontSize: 48.sp,
          //       letterSpacing: -0.41,
          //       lineHeight: 1.33,
          //       textAlign: TextAlign.left,
          //     ).animate(delay: 100.ms)
          //         .slide(
          //       begin: const Offset(0.3, 0),
          //       end: const Offset(0, 0), // End at center
          //       duration: 600.ms,
          //       curve: Curves.easeOutBack,
          //     )
          //         .fade(begin: 0, end: 1, duration: 600.ms),
          //   ),
          // ),
          //SliverGap(0.05.sh),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return CampaignWidget(
                  model: null,
                  onCardTap: (){
                    Get.to(()=> const CampaignDetails());
                  },
                ).animate()
                    .slide(
                  begin: const Offset(0, 0.3),
                  end: const Offset(0, 0), // End at center
                  duration: 600.ms + index.ms,
                  curve: Curves.easeOutBack,
                )
                    .fade(begin: 0, end: 1, duration: 600.ms);
              },
              childCount: 3,
            ),
          ),
          SliverGap(70.h),
        ],
      ),
    );
  }
}
