import 'dart:async';

import 'package:citizen_app/core/presentation/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../config/services/local_storage_service.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../constants/media.dart';
import '../../shared_widgets/default_text.dart';
import '../auth/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _handleLogin();
  }

  _handleLogin() async {
    _timer = Timer(const Duration(seconds: 2), () {
      if (CacheHelper.instance.isFirstTimer == false) {
        Get.offAll(() => const LoginScreen());
      } else {
        Get.offAll(() => const WelcomeScreen());
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.mainPrimaryColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Media.appIcon,
                  height: 130.h,
                  width: 130.h,
                )
                    .animate()
                    .slide(
                      begin: const Offset(0, -0.2), // Start from top of screen
                      end: const Offset(0, 0), // End at center
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOutBack,
                    )
                    .fade(begin: 0, end: 1, duration: 500.ms),
                DefaultText(
                  data: AppStrings.tagline,
                  fontFamily: "Geist",
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.white,
                  fontSize: 16.sp,
                  letterSpacing: -0.41,
                  lineHeight: 1.33,
                  textAlign: TextAlign.left,
                )
                    .animate(delay: 200.ms)
                    .slide(
                      begin: const Offset(0, -0.3), // Start from top of screen
                      end: const Offset(0, 0), // End at center
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOutBack,
                    )
                    .fade(begin: 0, end: 1, duration: 500.ms, delay: 200.ms),
              ],
            ),
          ),
        ));
  }
}
