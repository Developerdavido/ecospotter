import 'package:citizen_app/config/provider/providers.dart';
import 'package:citizen_app/config/services/local_storage_service.dart';
import 'package:citizen_app/config/services/supabase_service.dart';
import 'package:citizen_app/core/presentation/ui/views/profile/profile_widgets/build_badge_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/profile/profile_widgets/profile_top.dart';
import 'package:citizen_app/core/presentation/ui/views/profile/profile_widgets/user_profile_element.dart';
import 'package:citizen_app/core/presentation/ui/views/settings/edit_user_image.dart';
import 'package:citizen_app/core/presentation/ui/views/welcome/welcome_screen.dart';
import 'package:citizen_app/core/view_models/auth_provider.dart';
import 'package:citizen_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_loader.dart';
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
      backgroundColor: AppColors.primaryColorWhiteBackground,
      body: Consumer<AuthProvider>(builder: (context, authVm, _) {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primaryColorWhiteBackground,
              elevation: 0,
              surfaceTintColor: AppColors.primaryColorWhiteBackground,
              centerTitle: true,
              leading: const DefaultBackButton(
                iconColor: AppColors.blackOA,
                icon: CupertinoIcons.back,
                btnColor: AppColors.primaryColorWhiteBackground
              ),
              title: DefaultText(
                data: "Profile",
                fontWeight: FontWeight.w400,
                fontSize: 24.sp,
                textColor: AppColors.mainPrimaryColor,
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
                    ProfileTop(
                      avatar: authVm.userModel!.avatarUrl,
                      username: authVm.userModel!.username,
                      email: authVm.userModel!.email,
                    ),
                    Gap(12.h),
                    //this will show a list of the user earned badges
                    //BuildBadgeWidget(userId: authVm.userModel!.id,),
                    //Gap(12.h),
                    Expanded(
                        child: Column(
                      children: AnimateList(interval: 20.ms, effects: [
                        FadeEffect(duration: 300.ms),
                        SlideEffect(
                            delay: 200.ms,
                            begin: const Offset(0, -0.2),
                            end: const Offset(0, 0))
                      ], children: [
                        Gap(22.h),
                        UserProfileElement(
                            iconData: Icons.edit,
                            title: "Edit avatar",
                            callback: () {
                              Get.to(() => const EditUserImage());
                            }),
                        Gap(22.h),
                        UserProfileElement(
                            iconData: Icons.history_rounded,
                            title: "History",
                            callback: () {
                              //Get.to(() => const BookmarkedEvents());
                            }),
                        Gap(22.h),
                        UserProfileElement(
                            iconData: Icons.help_outline,
                            title: "Help and support",
                            callback: () {}),
                        Gap(44.h),
                        DefaultButton(
                            btnColor: Colors.transparent,
                            btnTextColor: AppColors.red,
                            btnFontWeight: FontWeight.w600,
                            onBtnTap: () async {
                              bool clearedCache = await CacheHelper.instance.clearCache();
                              if (clearedCache) {
                                authVm.clearData();
                                if (mounted) {
                                  resetAllProviders(context);
                                }
                                await SupabaseService.supabase.auth.signOut();
                                Get.offAll(() => const WelcomeScreen());
                              }
                            },
                            btnText: AppStrings.logout),
                      ]),
                    ))
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
