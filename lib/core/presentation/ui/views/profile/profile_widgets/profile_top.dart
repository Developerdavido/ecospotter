import 'package:citizen_app/core/presentation/ui/views/profile/profile_widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../constants/app_colors.dart';
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
        const ProfileWidget(image: null, isEdit: false),
        Gap(16.h),
        DefaultText(
          data: "@${username ?? "anon"}",
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          textColor: AppColors.lime,
          letterSpacing: -0.42,
          lineHeight: 1.2,
        ),
        DefaultText(
          data: email ?? "janedoe@gmail.com",
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          textColor: AppColors.white,
          letterSpacing: -0.42,
          lineHeight: 1.2,
        ),
      ],
    );
  }
}
