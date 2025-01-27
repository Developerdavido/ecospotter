import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/media.dart';
import '../../../shared_widgets/default_back_button.dart';
import '../../../shared_widgets/default_text.dart';
import '../../profile/user_info_screen.dart';


class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key,  this.username});

  final String? username;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 0.22.sh,
      backgroundColor: AppColors.mainPrimaryColor,
      pinned: true,
      floating: false,
      leading: Image.asset(
        Media.appIcon,
        height: 60.h,
      ),
      actions: [
        DefaultBackButton(
          icon: CupertinoIcons.person,
          btnColor: AppColors.mainPrimaryColor,
          onBackTap: () {
            Get.to(() => const UserProfileScreen());
          },
        ),
        const DefaultBackButton(
          btnColor: Colors.transparent,
          icon: CupertinoIcons.bell,
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Get the current height of the AppBar
          final double currentHeight = constraints.biggest.height;
          // Get the maximum height (expanded)
          final double maxHeight = MediaQuery.of(context).padding.top + 0.22.sh;

          // Calculate how expanded the app bar is (0.0 to 1.0)
          final double expandRatio = ((currentHeight - kToolbarHeight) /
              (maxHeight - kToolbarHeight)).clamp(0.0, 1.0);

          return FlexibleSpaceBar(
            background: Container(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: 16.0,
                top: kToolbarHeight + MediaQuery.of(context).padding.top,
              ),
              child: Opacity(
                // Fade out the text as the app bar collapses
                opacity: expandRatio,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DefaultText(
                      data: "Hello, $username",
                      fontWeight: FontWeight.bold,
                      fontSize: 32.sp,
                      textColor: AppColors.lime,
                      letterSpacing: -0.42,
                      lineHeight: 1.2,
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 0.2.sw),
                      child: DefaultText(
                        data: "Browse through running campaigns or take any available trivia right of the bat to earn points!",
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        textColor: AppColors.white,
                        letterSpacing: -0.42,
                        maxLines: 6,
                        lineHeight: 1.2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
