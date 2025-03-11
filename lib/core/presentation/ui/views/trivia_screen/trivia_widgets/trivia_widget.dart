import 'package:citizen_app/core/data/models/trivia_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../utils/utils.dart';
import '../../../shared_widgets/default_text.dart';

class TriviaWidget extends StatelessWidget {
  const TriviaWidget({super.key, this.pageController, this.currentAnswer, this.onAnswerClicked, this.onPageChanged, this.triviaModel});

  final PageController? pageController;
  final int? currentAnswer;
  final Function(int)? onAnswerClicked;
  final Function(int)? onPageChanged;
  final TriviaModel? triviaModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return PageView.builder(
              controller: pageController,
              onPageChanged: onPageChanged,
              itemCount: triviaModel!.questions.length,
              itemBuilder: (context, index) {
                var question = triviaModel!.questions[index];
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.minHeight,
                    ),
                    child: SizedBox(
                      height: constraints.minHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DefaultText(
                            data: "Question ${index + 1} / ${triviaModel!.questions.length}",
                            fontFamily: "Geist",
                            fontWeight: FontWeight.w900,
                            textColor: AppColors.lime,
                            fontSize: 16.sp,
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
                          Gap(8.h),
                          DefaultText(
                            data: question.subject ?? "",
                            fontFamily: "Geist",
                            fontWeight: FontWeight.w900,
                            textColor: AppColors.blackOA,
                            fontSize: 22.sp,
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
                          Gap(0.05.sh),
                          Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.w),
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.r),
                                    color: AppColors.borderColor
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    DefaultText(
                                      data: question.topic ?? "",
                                      fontFamily: "Geist",
                                      fontWeight: FontWeight.w500,
                                      textColor: AppColors.blackOA,
                                      fontSize: 18.sp,
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
                                    Gap(10.h),
                                    DefaultText(
                                      data: "${index + 1}. ${question.question}",
                                      fontFamily: "Geist",
                                      fontWeight: FontWeight.w500,
                                      textColor: AppColors.blackOA,
                                      fontSize: 16.sp,
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
                                    Gap(30.h),
                                    SizedBox(
                                      height: 0.3.sh,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: question.answers!.length,
                                          itemBuilder: (context, index) {
                                            var answer = question.answers![index];
                                            return GestureDetector(
                                              onTap: (){
                                                onAnswerClicked!(index);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                margin: EdgeInsets.only(bottom: 8.h),
                                                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.r),
                                                    color: currentAnswer != null && currentAnswer == index ? AppColors.lightGreen : AppColors.white
                                                ),
                                                child: Utils.regularText("${alphabetMap[index]} $answer", color: AppColors.greyedText, fontSize: 14.sp),
                                              ),
                                            );
                                          }
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),
                          Gap(0.1.sh)
                        ],
                      ),
                    ),
                  ),
                );
              }
          );
        }
    );
  }
}
