import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import 'default_text.dart';

class NavItem extends StatelessWidget {
  final IconData navData;
  final String navLabel;
  final Color navLabelColor;
  const NavItem(
      {super.key,
      required this.navData,
      required this.navLabel,
      required this.navLabelColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 60.h,
      width: 60.w,
      child: Center(
        child: Icon(
          navData,
          size: 24.sp,
          color: navLabelColor,
        ),
      )
    );
  }
}
