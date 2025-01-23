
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../../config/locator.dart';
import '../../../../../../config/services/auth_service.dart';
import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/app_strings.dart';
import '../../../../../../constants/media.dart';
import '../../../../../view_models/auth_provider.dart';
import '../../../shared_widgets/custom_app_bar.dart';
import '../../../shared_widgets/custom_button.dart';
import '../../../shared_widgets/default_loader.dart';
import '../../../shared_widgets/default_text.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthProvider? authVm;

  @override
  void initState() {
    authVm = context.read<AuthProvider>();
    authVm?.doesUserExistInLocalStorage();
    super.initState();
    locator<AuthService>().checkForUserStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    authVm = context.watch<AuthProvider>();
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
                            authVm?.loginUser();
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
            Visibility(
              visible: authVm!.isLoading || authVm!.loading,
              child: const Loader(),
            )
          ],
        ),
      ),
    );
  }
}
