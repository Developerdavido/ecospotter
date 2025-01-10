import 'package:cached_network_image/cached_network_image.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/default_back_button.dart';
import 'package:citizen_app/core/presentation/ui/views/campaign_posts/campaign_posts.dart';
import 'package:citizen_app/core/presentation/ui/views/capture_form/capture_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_strings.dart';
import '../../../../utils/utils.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_text.dart';


class CampaignDetails extends StatelessWidget {
  const CampaignDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              floating: false,
              pinned: true,
              backgroundColor: AppColors.white,
              elevation: 0,
              surfaceTintColor: Colors.transparent,
              leading:  DefaultBackButton(
                iconColor: AppColors.blackOA,
                icon: CupertinoIcons.back,
                btnColor: AppColors.white,
              )
            ),
            SliverGap(12.h),
            SliverToBoxAdapter(
              child: Hero(
                tag: 'tag',
                child: SizedBox(
                  height: 0.4.sh,
                  width: 1.sw,
                  child: CachedNetworkImage(
                    imageUrl: "",
                    fit: BoxFit.cover,
                    errorWidget: (context, dto, widget) {
                      return Container(
                        height: 0.4.sh,
                        width: 1.sw,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            size: 32.sp,
                            color: AppColors.blackOA,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverGap(12.h),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              data: "Bird Watch",
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp,
                              textColor: AppColors.blackOA,
                              letterSpacing: -0.42,
                              lineHeight: 1.2,
                            ),
                            Container(
                              height: 3.h,
                              width: 0.2.sw,
                              color: AppColors.blackOA,
                            ),
                            Gap(8.h),
                            DefaultText(
                              data: "${Utils.fullDate( DateTime.now())} - ${Utils.fullDate( DateTime.now())}",
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              textColor: AppColors.grey97,
                              letterSpacing: -0.42,
                              lineHeight: 1.2,
                            ),
                          ],
                        ),
                        DefaultText(
                          data:  "on-going".toUpperCase(),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          textColor: AppColors.green,
                          letterSpacing: -0.42,
                          lineHeight: 1.2,
                        ),
                      ],
                    ),
                    Gap(16.h),
                    DefaultText(
                      data: "Description",
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      textColor: AppColors.blackOA,
                      letterSpacing: -0.42,
                      lineHeight: 1.2,
                    ),
                    Container(
                      height: 3.h,
                      width: 0.15.sw,
                      color: AppColors.blackOA,
                    ),
                    Gap(8.h),
                    DefaultText(
                      data: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of de Finibus Bonorum et Malorum (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance.",
                      fontWeight: FontWeight.w300,
                      fontSize: 12.sp,
                      textColor: AppColors.grey97,
                      letterSpacing: -0.42,
                      maxLines: 10,
                      lineHeight: 1.6,
                    ),
                    Gap(20.h),
                    DefaultButton(
                        btnColor: AppColors.primaryColor,
                        btnTextColor: AppColors.white,
                        onBtnTap: (){
                          Get.to(()=> const CaptureForm());
                        }, btnText: AppStrings.participate),
                    Gap(10.h),
                    DefaultButton(
                        btnColor: AppColors.primaryColor,
                        btnTextColor: AppColors.white,
                        onBtnTap: (){
                          Get.to(()=> const CampaignPosts());
                        }, btnText: AppStrings.viewPosts),
                    Gap(20.h),
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
