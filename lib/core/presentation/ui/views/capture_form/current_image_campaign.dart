import 'package:citizen_app/core/presentation/ui/views/app_navigation/app_navigation_screen.dart';
import 'package:citizen_app/core/view_models/auth_provider.dart';
import 'package:citizen_app/core/view_models/campaign_view_model.dart';
import 'package:citizen_app/core/view_models/capture_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../../config/locator.dart';
import '../../../../../config/services/campaign_service.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_loader.dart';
import '../../shared_widgets/default_text.dart';
import '../../shared_widgets/dropdown_btn.dart';

class CurrentImageCampaign extends StatefulWidget {
  const CurrentImageCampaign({super.key});

  @override
  State<CurrentImageCampaign> createState() => _CurrentImageCampaignState();
}

class _CurrentImageCampaignState extends State<CurrentImageCampaign> {
  final TextEditingController? professionController = TextEditingController();
  final TextEditingController campaignCtrl = TextEditingController();
  String? chosenCampaign;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer3<CaptureProvider, CampaignProvider, AuthProvider>(builder: (context, vm, campVm, authVm, _) {
        return Scaffold(
          backgroundColor: AppColors.mainPrimaryColor,
          body: CustomScrollView(
            slivers: [
              const SliverAppBar(
                  floating: false,
                  pinned: true,
                  backgroundColor: AppColors.mainPrimaryColor,
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  leading: DefaultBackButton(
                    iconColor: AppColors.white,
                    icon: CupertinoIcons.back,
                    btnColor: AppColors.mainPrimaryColor,
                  )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Gap(20.h),
                          DefaultText(
                            data: AppStrings.conservationCampaignTitle,
                            fontFamily: "Geist",
                            fontWeight: FontWeight.w900,
                            textColor: AppColors.lime,
                            fontSize: 20.sp,
                            letterSpacing: -0.41,
                            lineHeight: 1.33,
                            textAlign: TextAlign.center,
                          )
                              .animate(delay: 100.ms)
                              .slide(
                                begin: const Offset(0, -0.3),
                                end: const Offset(0, 0), // End at center
                                duration: 600.ms,
                                curve: Curves.easeOutBack,
                              )
                              .fade(begin: 0, end: 1, duration: 600.ms),
                          Gap(4.h),
                          DefaultText(
                            data: AppStrings.conservationCampaignMessage,
                            fontFamily: "Geist",
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.white,
                            fontSize: 16.sp,
                            letterSpacing: -0.41,
                            lineHeight: 1.33,
                            textAlign: TextAlign.center,
                          )
                              .animate()
                              .slide(
                                begin: const Offset(0, -0.3),
                                end: const Offset(0, 0), // End at center
                                duration: 600.ms,
                                curve: Curves.easeOutBack,
                              )
                              .fade(begin: 0, end: 1, duration: 600.ms),
                          Gap(0.1.sh),
                          DropdownBtn(
                            controller: campaignCtrl,
                            title: "What campaign are you submitting for?",
                            height: 0.6.sh,
                            hintText: "Select campaign",
                            labelText: chosenCampaign,
                            items: campVm.campaigns.map((e) => e.title).toList(),
                            onChanged: (campaign) {
                              setState(() {
                                chosenCampaign = campaign;
                                vm.campaignId = campVm.campaigns.firstWhere((test) => test.title == campaign).id;
                              });
                            },
                          )
                              .animate()
                              .slide(
                                begin: const Offset(0, -0.3),
                                end: const Offset(0, 0), // End at center
                                duration: 600.ms,
                                curve: Curves.easeOutBack,
                              )
                              .fade(begin: 0, end: 1, duration: 600.ms),
                          Gap(40.h),
                          DefaultButton(
                              btnColor: AppColors.green5C,
                              btnTextColor: AppColors.mainBlack,
                              onBtnTap: () {

                                vm.uploadCapture(authVm.userModel!.id,
                                    authVm.userModel!.username!);
                               },
                              btnText: AppStrings.submit),
                        ],
                      ),
                      Visibility(
                        visible: vm.isLoading,
                        child: const Loader(),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
