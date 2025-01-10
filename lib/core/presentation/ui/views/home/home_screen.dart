import 'package:citizen_app/core/constants/app_colors.dart';
import 'package:citizen_app/core/presentation/ui/views/campaign_details/campaign_details.dart';
import 'package:citizen_app/core/presentation/ui/views/home/home_widgets/activity_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/home/home_widgets/campaign_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../constants/app_strings.dart';
import '../../../../constants/media.dart';
import '../../shared_widgets/default_back_button.dart';
import 'home_widgets/custom_home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: AppColors.white,
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
                  const DefaultBackButton(
                    icon: CupertinoIcons.person,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  const DefaultBackButton(
                    icon: CupertinoIcons.bell,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                ],
              )
            ],
          ),
          SliverGap(12.h),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return CampaignWidget(
                  model: null,
                  onCardTap: (){
                    Get.to(()=> const CampaignDetails());
                  },
                );
              },
              childCount: 3,
            ),
          ),
          // SliverGap(12.h),
          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //         (BuildContext context, int index) {
          //       return const ActivityWidget(
          //         model: null,
          //       );
          //     },
          //     childCount: 20,
          //   ),
          // ),
          SliverGap(70.h),
        ],
      ),
    );
  }
}
