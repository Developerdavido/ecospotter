import 'dart:async';
import 'dart:ui';

import 'package:citizen_app/config/locator.dart';
import 'package:citizen_app/config/services/dialog_service.dart';
import 'package:citizen_app/core/presentation/ui/views/campaign_details/campaign_details_widgets/campaign_app_bar.dart';
import 'package:citizen_app/core/presentation/ui/views/campaign_posts/campaign_posts.dart';
import 'package:citizen_app/core/presentation/ui/views/capture_form/capture_form.dart';
import 'package:citizen_app/core/view_models/ai_provider.dart';
import 'package:citizen_app/core/view_models/auth_provider.dart';
import 'package:citizen_app/core/view_models/campaign_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
import '../../../../../utils/utils.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_loader.dart';
import '../../shared_widgets/default_text.dart';
import '../../shared_widgets/modal_expandable_custom.dart';
import '../badges/widget/badge_trivia_and_description.dart';
import '../trivia_screen/trivia_screen.dart';

class CampaignDetails extends StatefulWidget {
  const CampaignDetails({super.key});

  @override
  State<CampaignDetails> createState() => _CampaignDetailsState();
}

class _CampaignDetailsState extends State<CampaignDetails> {
  final _dataStreamController = StreamController<Map<String, dynamic>?>.broadcast();
  final FocusScopeNode _focusNode = FocusScopeNode();

  AIVm? aiVm;

  makeTheApiCall(String trivia) async {
    // Only make the call if we have some input
    final isInternetPresent = await Utils.isInternetPresent();
    if (!isInternetPresent) return;
    Map<String, dynamic>? nameDesc = await aiVm!.getAnimalDescription(trivia);
    _dataStreamController.add(nameDesc);
  }

  @override
  void initState() {
    // TODO: implement initState
    aiVm = context.read<AIVm>();
    super.initState();
  }

  //this will clear the
  void _clearData() {
    _dataStreamController.add(null);
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<CampaignProvider, AIVm, AuthProvider>(builder: (context, campaignVm, aiVm, authVm, child) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryColorWhiteBackground,
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  CampaignDetailsAppBar(
                    model: campaignVm.currentCampaign,
                    onInfoTap: () async {
                      await makeTheApiCall(campaignVm.currentCampaign!.topic!);
                    },
                  ),
                  SliverGap(12.h),
                  SliverFillRemaining(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: Stack(
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: AnimateList(
                                interval: 20.ms,
                                effects: [
                                  SlideEffect(delay: 200.ms, begin: const Offset(0, 0.3), end: const Offset(0, 0)),
                                  FadeEffect(duration: 300.ms),
                                ],
                                children: [
                                  DefaultText(
                                    data: "Description",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp,
                                    textColor: AppColors.mainPrimaryColor,
                                    letterSpacing: -0.42,
                                    lineHeight: 1.2,
                                  ),
                                  Gap(8.h),
                                  DefaultText(
                                    data: campaignVm.currentCampaign!.description,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14.sp,
                                    textColor: AppColors.blackOA,
                                    letterSpacing: -0.42,
                                    maxLines: 10,
                                    lineHeight: 1.6,
                                  ),
                                  Gap(24.h),
                                  SizedBox(
                                    width: 1.sw,
                                    height: 0.2.sh,
                                    child: ClipRect(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                                            child: Column(
                                              children: [
                                                Gap(20.h),
                                                DefaultButton(
                                                    btnColor: AppColors.mainPrimaryColor,
                                                    btnTextColor: AppColors.white,
                                                    onBtnTap: () async {
                                                      if (campaignVm.currentCampaign!.type.toLowerCase() == 'trivia') {
                                                        final isInternetPresent = await Utils.isInternetPresent();
                                                        //is internet not present
                                                        if (!isInternetPresent) {
                                                          locator<DialogService>().showSnackBar("No Internet", "Cannot generate trivia at this time. Please try again when connected to the internet");
                                                          return;
                                                        }
                                                        //if the internet is present get the current campaign
                                                        await aiVm.getTrivia(campaignVm.currentCampaign!.topic!, authVm.userModel!.profession!);
                                                        if (aiVm.trivia != null) Get.to(() => const TriviaScreen());
                                                        return;
                                                      }
                                                      Get.to(() => const CaptureForm(
                                                            isHome: false,
                                                          ));
                                                    },
                                                    btnText: AppStrings.participate),
                                                Gap(10.h),
                                                Visibility(
                                                  visible: campaignVm.currentCampaign!.type.toLowerCase() != 'trivia',
                                                  child: DefaultButton(
                                                      btnColor: AppColors.mainPrimaryColor.withValues(alpha: 0.1),
                                                      btnTextColor: AppColors.blackOA,
                                                      onBtnTap: () {
                                                        Get.to(() => const CampaignPosts());
                                                      },
                                                      btnText: AppStrings.viewPosts),
                                                ),
                                                Gap(20.h),
                                              ],
                                            )),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          Visibility(
                            visible: authVm.isLoading || aiVm.isLoading,
                            child: Loader(loaderText: aiVm.isLoading ? "Generating trivia..." : "Loading..."),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              //this is the custom expandable widget
              // Positioned(
              //   bottom: 0,
              //   left: 0,
              //   right: 0,
              //   child: ModalExpandableCustom(
              //       dataStream: _dataStreamController.stream,
              //       collapsedHeight: 0.15.sh,
              //       expandedHeight: 0.5.sh,
              //       onBackPressed: () {
              //         setState(() {
              //           _clearData();
              //         });
              //       },
              //       contentBuilder: (data, isExpanded) {
              //         return BadgeTriviaAndDescription(
              //           isExpanded: isExpanded,
              //           trivia: data['trivia'],
              //           description: data['description'],
              //           errorMessage: data['message'],
              //         );
              //       }),
              // ),
            ],
          ),
        ),
      );
    });
  }
}
