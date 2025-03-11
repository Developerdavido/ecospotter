import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../constants/app_colors.dart';



class ReusableSystemOverlay extends StatelessWidget {
  const ReusableSystemOverlay({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
      ), child: child,);
  }
}
