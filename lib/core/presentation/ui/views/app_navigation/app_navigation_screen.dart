import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../config/services/navigation_service.dart';
import '../../../../../constants/app_colors.dart';
import '../../shared_widgets/bottom_nav.dart';



class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {

  int currentIndex = 0;

  changeTheCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          NavService.selectedScreen(currentIndex)!,
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: BottomNav(currentIndex: currentIndex, getCurrentIndex: (index) {
                changeTheCurrentIndex(index);
              }).animate().fade().scale(delay: 500.ms,))
        ],
      ),
    );
  }
}
