import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constants/app_colors.dart';

class CaptureImage extends StatelessWidget {
  const CaptureImage({super.key, this.onImageTap, this.imagePath});

  final VoidCallback? onImageTap;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onImageTap,
      child: Container(
        height: 0.3.sh,
        width: 0.6.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: imagePath == null
            ? const Icon(
                Icons.add_a_photo_outlined,
                size: 56,
                color: AppColors.grey97,
              )
            : Image.asset(
                imagePath!,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
