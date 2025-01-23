import 'package:citizen_app/core/presentation/ui/views/profile/profile_widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../../../constants/app_colors.dart';
import '../../../shared_widgets/default_text.dart';


class ProfileTop extends StatelessWidget {
  const ProfileTop({super.key, this.avatar, this.username, this.email});
  final String? avatar;
  final String? username;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileWidget(image: null, isEdit: false).animate().scale(
      delay: 200.ms,
      duration: 500.ms,
      begin: const Offset(0.8, 0.8),
      end: const Offset(1, 1), // 10% size increase
      curve: Curves.easeOut,
    ),
        Gap(16.h),
        DefaultText(
          data: "@${username ?? "anon"}",
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          textColor: AppColors.lime,
          letterSpacing: -0.42,
          lineHeight: 1.2,
        ).animate(delay: 100.ms)
        .slide(
    begin: const Offset(0, 0.2), // Start from top of screen
    end: const Offset(0, 0), // End at center
    duration: 500.ms,
    curve: Curves.easeOutBack,
    )
        .fade(begin: 0, end: 1, duration: 500.ms),
        DefaultText(
          data: email ?? "janedoe@gmail.com",
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          textColor: AppColors.white,
          letterSpacing: -0.42,
          lineHeight: 1.2,
        ).animate(delay: 150.ms)
            .slide(
          begin: const Offset(0, 0.2), // Start from top of screen
          end: const Offset(0, 0), // End at center
          duration: 500.ms,
          curve: Curves.easeOutBack,
        )
            .fade(begin: 0, end: 1, duration: 500.ms),
      ],
    );
  }
}
