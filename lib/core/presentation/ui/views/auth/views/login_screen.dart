import 'dart:developer';

import 'package:citizen_app/core/config/env_config/env_config.dart';
import 'package:citizen_app/core/config/locator.dart';
import 'package:citizen_app/core/config/provider/auth_provider.dart';
import 'package:citizen_app/core/config/services/auth_service.dart';
import 'package:citizen_app/core/domain/repositories/auth_repository.dart';
import 'package:citizen_app/core/domain/usecases/auth/login_user.dart';
import 'package:citizen_app/core/presentation/ui/views/auth/views/add_profession_screen.dart';
import 'package:citizen_app/core/presentation/ui/views/auth/views/username_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../constants/media.dart';
import '../../../shared_widgets/custom_app_bar.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/default_text.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthProvider provider = AuthProvider();

  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locator<AuthService>().checkForUserStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.mainPrimaryColor,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(20.h),
                const CustomLoginAppBar(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Gap(20.h),
                        DefaultText(
                          data: AppStrings.loginTitle,
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
                          data: AppStrings.loginMessage,
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
                        Gap(40.h),
                        DefaultButton(
                          onBtnTap: () async {
                            // var success  = await authVm.loginUser(AuthMethod.google);
                            // if(success){
                            // Get.to(() => const ChooseUsername(),
                            //     transition: Transition.cupertino);
                            // }
                            await provider.loginUser();
                          },
                          btnText: AppStrings.googleLogin,
                          isIconPresent: true,
                          iconData: Media.google,
                          btnColor: AppColors.green5C,
                          btnTextColor: AppColors.mainBlack,
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(16.h),
                DefaultText(
                  data: AppStrings.trademark,
                  fontFamily: "Geist",
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.lime,
                  fontSize: 12.sp,
                  letterSpacing: -0.14,
                  lineHeight: 2.1,
                  textAlign: TextAlign.center,
                ),
                Gap(16.h)
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
