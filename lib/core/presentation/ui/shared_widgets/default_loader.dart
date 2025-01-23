import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/media.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
              height: 99.h,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(color: AppColors.white.withOpacity(0.2)),
              child: SizedBox(
                  height: 0.1.sh,
                  width: 0.1.sh,
                  child: Center(
                    child: SvgPicture.asset(
                      height: 0.1.sh,
                      width: 0.1.sh,
                      Media.loader,
                      colorFilter:
                          const ColorFilter.mode(AppColors.bottomModal, BlendMode.srcIn),
                    ),
                  )
                      .animate(
                        // Make the animation repeat indefinitely
                        onPlay: (controller) => controller.repeat(reverse: true),
                      )
                      .scale(
                        // Scale up to 1.2x size
                        begin: const Offset(1, 1),
                        end: const Offset(1.2, 1.2),
                        duration: 800.ms,
                        curve: Curves.easeInOut,
                      )
                      .scale(
                        // Scale back down to original size
                        delay: 300.ms,
                        begin: const Offset(1.2, 1.2),
                        end: const Offset(1, 1),
                        duration: 800.ms,
                        curve: Curves.easeOut,
                      )
                      // Optional: Add fade effect
                      .fadeIn(
                        duration: 600.ms,
                      ))),
        ),
      ),
    );
  }
}
