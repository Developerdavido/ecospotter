import 'package:citizen_app/core/data/models/trivia_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../constants/prompts.dart';
import '../../../../../../utils/utils.dart';
import '../../../shared_widgets/default_text.dart';

class TriviaWidget extends StatelessWidget {
  const TriviaWidget({super.key, this.pageController, this.currentAnswer, this.onAnswerClicked, this.onPageChanged, this.subject, this.triviaModel});

  final String? subject;
  final PageController? pageController;
  final String? currentAnswer;
  final Function(String)? onAnswerClicked;
  final Function(int)? onPageChanged;
  final TriviaModel? triviaModel;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
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
                        textColor: AppColors.mainPrimaryColor,
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: AppColors.borderColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DefaultText(
                              data: "${index + 1}. ${question.question}",
                              fontFamily: "Geist",
                              fontWeight: FontWeight.w500,
                              textColor: AppColors.blackOA,
                              fontSize: 16.sp,
                              letterSpacing: -0.41,
                              maxLines: 10,
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
                                      onTap: () {
                                        onAnswerClicked!(answer);
                                      },
                                      child: Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(bottom: 8.h),
                                          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.r), color: currentAnswer != null && currentAnswer!.toLowerCase() == answer.toLowerCase() ? AppColors.mainPrimaryColor : AppColors.white),
                                          child: DefaultText(
                                            data: "${alphabetMap[index]} $answer",
                                            textColor: currentAnswer != null && currentAnswer!.toLowerCase() == answer.toLowerCase() ? AppColors.white : AppColors.grey35,
                                            fontSize: 14.sp,
                                          )),
                                    );
                                  }),
                            ),
                            Gap(10.h),
                            DefaultText(
                              data: "Instructions.",
                              fontFamily: "Geist",
                              fontWeight: FontWeight.w900,
                              textColor: AppColors.mainPrimaryColor,
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
                            ).fade(begin: 0, end: 1, duration: 600.ms),
                           Gap(16.h),
                            DefaultText(
                              data: "* Select an answer clicking on an option.",
                              fontFamily: "Geist",
                              fontWeight: FontWeight.w500,
                              textColor: AppColors.mainPrimaryColor,
                              fontSize: 18.sp,
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
                            ).fade(begin: 0, end: 1, duration: 600.ms),
                            Gap(10.h),
                            DefaultText(
                              data: "* To change questions, swipe left or right.",
                              fontFamily: "Geist",
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.mainPrimaryColor,
                              fontSize: 18.sp,
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
                            ).fade(begin: 0, end: 1, duration: 600.ms),
                            Gap(10.h),
                            DefaultText(
                              data: "* Before finally submitting, ensure that all questions have been answered",
                              fontFamily: "Geist",
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.mainPrimaryColor,
                              fontSize: 18.sp,
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
                            ).fade(begin: 0, end: 1, duration: 600.ms),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
