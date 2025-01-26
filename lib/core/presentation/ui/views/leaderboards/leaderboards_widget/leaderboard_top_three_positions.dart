import 'package:citizen_app/core/data/models/ranking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'leaderboard_top_widget.dart';



class LeaderTopThreePositions extends StatelessWidget {
  const LeaderTopThreePositions({super.key, this.leaderboards});

  final List<LeaderboardModel>? leaderboards;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.45.sh,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      width: 1.sw,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        children: [
          Positioned(
            bottom: 18.h,
            left: 0.06.sw,
            child: LeaderBoardTopWidget(
              position: 2,
              username: leaderboards?[1].username,
              points: leaderboards?[1].points,
            ).animate()
                .slide(
              begin: const Offset(-0.4, 0),
              end: const Offset(0, 0), // End at center
              duration: 600.ms,
              curve: Curves.easeOutBack,
            )
                .fade(begin: 0, end: 1, duration: 600.ms),),
          Positioned(
            bottom: 18.h,
            right: 0.06.sw,
            child: LeaderBoardTopWidget(
              position: 3,
              username: leaderboards?[2].username,
              points: leaderboards?[2].points,
            ).animate()
                .slide(
              begin: const Offset(0.4, 0),
              end: const Offset(0, 0), // End at center
              duration: 600.ms,
              curve: Curves.easeOutBack,
            )
                .fade(begin: 0, end: 1, duration: 600.ms),),
          Positioned(
            top: 24.h,
            left: 0,
            right: 0,
            child: LeaderBoardTopWidget(
              position: 1,
              username: leaderboards?[0].username,
              points: leaderboards?[0].points,
            ).animate()
                .slide(
              begin: const Offset(0, -0.4),
              end: const Offset(0, 0), // End at center
              duration: 600.ms,
              curve: Curves.easeOutBack,
            )
                .fade(begin: 0, end: 1, duration: 600.ms),),
        ],
      ),
    );
  }
}
