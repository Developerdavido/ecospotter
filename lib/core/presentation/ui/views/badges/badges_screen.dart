import 'dart:developer';

import 'package:citizen_app/config/services/supabase_service.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/default_loader.dart';
import 'package:citizen_app/core/presentation/ui/views/badges/widget/user_badges_progress_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../view_models/auth_provider.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_text.dart';

class BadgesScreen extends StatelessWidget {
  const BadgesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = Provider.of<AuthProvider>(context);
      return Scaffold(
        backgroundColor: AppColors.primaryColorWhiteBackground,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              pinned: true,
              backgroundColor: AppColors.primaryColorWhiteBackground,
              elevation: 0,
              surfaceTintColor: AppColors.primaryColorWhiteBackground,
              centerTitle: true,
              leading: const DefaultBackButton(
                  iconColor: AppColors.blackOA,
                  icon: CupertinoIcons.back,
                  btnColor: AppColors.primaryColorWhiteBackground
              ),
              title: DefaultText(
                data: "Badges",
                fontWeight: FontWeight.w400,
                fontSize: 24.sp,
                textColor: AppColors.mainPrimaryColor,
                letterSpacing: -0.42,
                lineHeight: 1.2,
              ),
            ),
            SliverFillRemaining(
              child: StreamBuilder<Map<String,dynamic>>(
                stream: SupabaseService.supabase.from('profiles').stream(primaryKey: ['id']).eq('id', authVm.userModel!.id).map((body) => body.first),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Loader());
                  }

                  if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(child: Text('Failed to load user points'));
                  }

                  final userPoints = snapshot.data!['points'] as int;

                  return UserBadgesProgressList(
                  userId: authVm.userModel!.id,
                    points: userPoints,
                  );
                }
              ),
            )
          ],
        )
      );
  }
}
