import 'dart:async';

import 'package:citizen_app/core/presentation/ui/views/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../config/services/local_storage_service.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/media.dart';



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
    //bool userPresent = await locator<AuthService>().doesUserExist();
    _timer = Timer(const Duration(seconds: 2), () {
      if (!CacheHelper.instance.isFirstTimer) {
        Get.offAll(()=> const AppNavigation());
      } else {
        Get.offAll(()=> const WelcomeScreen());
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
        backgroundColor: AppColor.primaryColor,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Image.asset(Media.appIcon, height: 50.h,),
          ),
        )
    );
  }
}
