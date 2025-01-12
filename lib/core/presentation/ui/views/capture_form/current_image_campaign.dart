import 'package:citizen_app/core/config/services/campaign_service.dart';
import 'package:citizen_app/core/presentation/ui/views/app_navigation/app_navigation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../config/locator.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_back_button.dart';
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
      child: Scaffold(
        backgroundColor: AppColors.mainPrimaryColor,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
                floating: false,
                pinned: true,
                backgroundColor: AppColors.mainPrimaryColor,
                elevation: 0,
                surfaceTintColor: Colors.transparent,
                leading:  DefaultBackButton(
                  iconColor: AppColors.white,
                  icon: CupertinoIcons.back,
                  btnColor: AppColors.mainPrimaryColor,
                )
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
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
                    ),
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
                    ),
                    Gap(0.1.sh),
                    DropdownBtn(
                      controller: campaignCtrl,
                      title: "What campaign are you submitting for?",
                      height: 0.6.sh,
                      hintText: "Select campaign",
                      labelText: chosenCampaign,
                      items: locator<CampaignService>().campaigns,
                      onChanged: (campaign){
                        setState(() {
                          chosenCampaign = campaign;
                        });
                      },
                    ),
                    Gap(40.h),
                    DefaultButton(
                        btnColor: AppColors.green5C,
                        btnTextColor: AppColors.mainBlack,
                        onBtnTap: (){
                          Get.offAll(()=> const AppNavigation());
                        }, btnText: AppStrings.submit),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
