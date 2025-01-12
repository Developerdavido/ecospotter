import 'package:citizen_app/core/presentation/ui/views/capture_form/capture_form.dart';
import 'package:citizen_app/core/presentation/ui/views/home/home_screen.dart';
import 'package:citizen_app/core/presentation/ui/views/leaderboards/leaderboard_screen.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/media.dart';
import '../../presentation/ui/shared_widgets/nav_item.dart';

class NavService {

  //get the navigation items
  static List<NavItem> navigationItems({bool isSelected = false}) {
    return [
      NavItem(
          navData: isSelected ? Icons.dashboard : Icons.dashboard_outlined,
          navLabel: "Dashboard",
          navLabelColor: isSelected ? AppColors.green5C : AppColors.unselectedColor),
      NavItem(
          navData: Icons.camera,
          navLabel: "Capture",
          navLabelColor: isSelected ? AppColors.green5C : AppColors.unselectedColor),
      NavItem(
          navData: isSelected ? Icons.leaderboard : Icons.leaderboard_outlined,
          navLabel: "Rankings",
          navLabelColor: isSelected ? AppColors.green5C : AppColors.unselectedColor),
      // NavItem(
      //     navData: isSelected ? Media.eventsFilled : Media.eventsUnfilled,
      //     navLabel: "Leaderboard",
      //     navLabelColor: isSelected ? AppColors.white : AppColors.unselectedColor),
    ];
  }

  //get the widgets for the screens
  static Widget? selectedScreen(int currentIndex) {
    List<Widget?> screens = [
      const HomeScreen(),
      const CaptureForm(),
      const LeaderboardScreen(),
    ];
    if (screens[currentIndex] != null) {
      return screens[currentIndex];
    }
    return null;
  }

}