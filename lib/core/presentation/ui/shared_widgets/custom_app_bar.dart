import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/media.dart';
import 'default_back_button.dart';



class CustomLoginAppBar extends StatelessWidget {
  const CustomLoginAppBar({super.key, this.imageString});
  final String? imageString;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width: 1.sw,
      color: AppColors.white,
      child: Row(
        children: [
          const DefaultBackButton(icon: CupertinoIcons.left_chevron,),
          Gap(0.3.sw),
          //Image.asset(Media.appIcon, height: 60.h, width: 60.h, fit: BoxFit.cover,),
          //const Spacer(),
        ],
      ),
    );
  }
}