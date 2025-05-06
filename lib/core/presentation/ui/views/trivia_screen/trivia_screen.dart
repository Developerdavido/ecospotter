import 'dart:developer';

import 'package:citizen_app/config/locator.dart';
import 'package:citizen_app/config/services/dialog_service.dart';
import 'package:citizen_app/core/data/models/trivia_model.dart';
import 'package:citizen_app/core/presentation/ui/views/trivia_screen/trivia_result_route.dart';
import 'package:citizen_app/core/presentation/ui/views/trivia_screen/trivia_widgets/annotated_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/trivia_screen/trivia_widgets/custom_alert_dialog.dart';
import 'package:citizen_app/core/presentation/ui/views/trivia_screen/trivia_widgets/linear_progress_bar.dart';
import 'package:citizen_app/core/presentation/ui/views/trivia_screen/trivia_widgets/trivia_widget.dart';
import 'package:citizen_app/core/view_models/auth_provider.dart';
import 'package:citizen_app/core/view_models/campaign_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../constants/media.dart';
import '../../../../view_models/ai_provider.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_loader.dart';
import '../../shared_widgets/default_text.dart';

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({super.key});

  @override
  State<TriviaScreen> createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  double? progressValue;

  PageController? controller;

  Map<int, String> answers = {};
  AIVm? aiVm;

  bool isLastPage = false;

  int currentPage = 0;
  @override
  void initState() {
    aiVm = context.read<AIVm>();
    super.initState();
    controller = PageController();
    progressValue = 1 / aiVm!.trivia!.questions.length;
  }

  bool isAnswerPresent() {
    return answers[currentPage] == null ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthProvider, CampaignProvider, AIVm>(builder: (context, authVm, campaignVm, aiVm, child) {
      return SafeArea(
          child: ReusableSystemOverlay(
              child: Scaffold(
        backgroundColor: AppColors.primaryColorWhiteBackground,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: false,
                pinned: true,
                backgroundColor: AppColors.primaryColorWhiteBackground,
                elevation: 0,
                surfaceTintColor: AppColors.primaryColorWhiteBackground,
                centerTitle: true,
                leading: const DefaultBackButton(iconColor: AppColors.blackOA, icon: CupertinoIcons.back, btnColor: AppColors.primaryColorWhiteBackground),
                title: DefaultText(
                  data: "${campaignVm.currentCampaign!.topic} Trivia",
                  fontWeight: FontWeight.w400,
                  fontSize: 24.sp,
                  textColor: AppColors.mainPrimaryColor,
                  letterSpacing: -0.42,
                  lineHeight: 1.2,
                ),
              ),
              SliverGap(10.h),
              SliverFillRemaining(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Gap(10.h),
                        LinearProgressBar(
                          progressValue: progressValue!,
                        ),
                        Gap(10.h),
                        Expanded(
                          child: TriviaWidget(
                            subject: campaignVm.currentCampaign!.topic,
                            pageController: controller,
                            triviaModel: aiVm.trivia,
                            currentAnswer: answers[currentPage],
                            onAnswerClicked: (index) {
                              setState(() {
                                answers[currentPage] = index;
                              });
                            },
                            onPageChanged: (page) {
                              setState(() {
                                int totalQuestions = aiVm.trivia!.questions.length;
                                progressValue = (1 / totalQuestions) * (page + 1);
                                currentPage = page;
                                isLastPage = (page == aiVm.trivia!.questions.length - 1);
                              });
                            },
                          ),
                        ),
                        Gap(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Media.ai,
                              height: 15.h,
                              width: 15.w,
                              colorFilter: const ColorFilter.mode(AppColors.mainPrimaryColor, BlendMode.srcIn),
                            ),
                            Gap(5.w),
                            DefaultText(
                              data: "Powered by Gemini AI Model",
                              fontFamily: "Geist",
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.mainPrimaryColor,
                              fontSize: 12.sp,
                              letterSpacing: -0.41,
                              lineHeight: 1.33,
                              textAlign: TextAlign.left,
                            )
                                .animate(delay: 100.ms)
                                .slide(
                                  begin: const Offset(0, -0.3),
                                  end: const Offset(0, 0), // End at center
                                  duration: 600.ms,
                                  curve: Curves.easeOutBack,
                                )
                                .fade(begin: 0, end: 1, duration: 600.ms),
                          ],
                        ),
                        Gap(10.h),
                      ],
                    ),
                    Visibility(
                      visible: authVm.isLoading || aiVm.isLoading,
                      child: Loader(loaderText: aiVm.isLoading ? "Saving user points" : "Loading..."),
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        bottomNavigationBar: !isLastPage
          ? const SizedBox.shrink()
          : Padding(
            padding: const EdgeInsets.all(12.0),
            child: DefaultButton(
              btnColor: AppColors.mainPrimaryColor,
              btnTextColor: AppColors.white,
              onBtnTap: () {
                //get all the valid answers, multiply by 2 and send to api
                int points = aiVm.getPoints(answers);
                //save the points and then update the badges
                aiVm.updateUserPoints(authVm.userModel!.id, points).whenComplete(() {
                  //update user points
                  authVm.retrieveUserAndUpdateProfile(authVm.userModel!.id);
                  //TODO: clear the data and go back to the page
                  Get.back();
                  if(mounted) {
                    locator<DialogService>().showCustomDialog(context: context, customDialog: CustomAlertDialog(
                      title: "Congratulations 🥳",
                      message: "You got $points points from the trivia. Retake the trivia to rack up more points and move up the leaderboard.",
                    ));
                  }
                });
              },
              btnText: AppStrings.submit),
          ),
      )));
    });
  }
}
