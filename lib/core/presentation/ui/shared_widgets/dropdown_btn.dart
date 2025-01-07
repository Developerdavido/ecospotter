import 'package:citizen_app/core/config/locator.dart';
import 'package:citizen_app/core/config/services/dialog_service.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import 'default_back_button.dart';
import 'default_text.dart';

class DropdownBtn extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final String? hintText;
  final Function(String?)? onChanged;
  final List<String>? items;
  final String? labelText;
  const DropdownBtn(
      {super.key,
      required this.controller,
      this.title,
      this.hintText,
      this.onChanged,
        this.labelText,
      this.items});

  @override
  Widget build(BuildContext context) {
    return InputField(
      controller: controller,
      readOnly: true,
      hintText: hintText,
      labelText: labelText,
      keyboardType: TextInputType.text,
      onTap: () {
        locator<DialogService>().showCustomModal(
            context: context,
            isDismissible: false,
            barrierColor: AppColors.primaryColor.withOpacity(0.1),
            customModal: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              color: AppColors.primaryColor,
              height: 0.75.sh,
              width: 1.sw,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultBackButton(
                    onBackTap: () {
                      Get.back();
                    },
                  ),
                  Gap(20.h),
                  DefaultText(
                    data: AppStrings.select,
                    fontFamily: "Geist",
                    fontWeight: FontWeight.w400,
                    textColor: AppColors.blackOA,
                    fontSize: 20.sp,
                    letterSpacing: -0.41,
                    lineHeight: 1.6,
                    textAlign: TextAlign.center,
                  ),
                  Gap(40.h),
                  Expanded(
                      child: ListView.builder(
                          itemCount: items!.length,
                          itemBuilder: (context, index) {
                            var item = items?[index];
                            return GestureDetector(
                              onTap: () {
                                onChanged!(item);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    DefaultText(
                                      data: item!,
                                      fontFamily: "Geist",
                                      fontWeight: FontWeight.w500,
                                      textColor: AppColors.blackOA,
                                      fontSize: 16.sp,
                                      letterSpacing: -0.41,
                                      lineHeight: 1.3,
                                      textAlign: TextAlign.left,
                                    ),
                                    Visibility(
                                      visible: labelText == item,
                                        child: Icon(
                                          CupertinoIcons.checkmark_alt,
                                          size: 16.sp,
                                          color: AppColors.green,
                                        ))
                                  ],
                                ),
                              ),
                            );
                          })),
                  //Gap(0.15.sh)
                ],
              ),
            ));
      },
    );
  }
}
