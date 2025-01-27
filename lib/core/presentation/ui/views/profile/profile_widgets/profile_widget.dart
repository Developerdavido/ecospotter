import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

import '../../../../../../constants/app_colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, this.isEdit = false, this.onImageTap, this.imagePath, this.image});

  final bool isEdit;
  final VoidCallback? onImageTap;
  final String? imagePath;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: isEdit ? onImageTap : null,
          child: CircleAvatar(
              backgroundColor: AppColors.white.withOpacity(0.1),
              radius: 65.r,
              child: image == null || image!.isEmpty
                  ? Center(
                child: Icon(
                  Icons.person,
                  size: 48.sp,
                  color: AppColors.white,
                ),
              )
                  : imagePath != null
                  ? CircleAvatar(radius: 65.r, foregroundImage: FileImage(File(image!),))
                  : CircleAvatar(radius: 65.r, foregroundImage: NetworkImage(image!))),
        ),
      ],
    );
  }
}
