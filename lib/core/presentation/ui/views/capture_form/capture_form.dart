import 'dart:io';

import 'package:citizen_app/config/services/dialog_service.dart';
import 'package:citizen_app/config/services/location_service.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/text_field.dart';
import 'package:citizen_app/core/presentation/ui/views/capture_form/animal_activity_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/capture_form/capture_widgets/capture_image.dart';
import 'package:citizen_app/core/view_models/capture_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../../config/locator.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../constants/app_strings.dart';
import '../../shared_widgets/custom_button.dart';
import '../../shared_widgets/default_back_button.dart';
import '../../shared_widgets/default_loader.dart';
import '../../shared_widgets/default_text.dart';


class CaptureForm extends StatefulWidget {
  const CaptureForm({super.key, this.isHome = true});

  final bool isHome;

  @override
  State<CaptureForm> createState() => _CaptureFormState();
}

class _CaptureFormState extends State<CaptureForm> {
  final TextEditingController nameCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File? imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locator<LocationService>().startListening();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    locator<LocationService>().stopListening();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<CaptureProvider>(
      builder: (context, vm, child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.mainPrimaryColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                    floating: false,
                    pinned: true,
                    backgroundColor: AppColors.mainPrimaryColor,
                    elevation: 0,
                    surfaceTintColor: Colors.transparent,
                    leading:  widget.isHome ? null : const DefaultBackButton(
                      iconColor: AppColors.white,
                      icon: CupertinoIcons.back,
                      btnColor: AppColors.mainPrimaryColor,
                    )
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Stack(
                      children: [
                        Column(
                          children: AnimateList(
                            interval: 20.ms,
                            effects: [
                              SlideEffect(delay: 200.ms, begin: const Offset(0, 0.3), end: const Offset(0, 0)),
                              FadeEffect(duration: 300.ms),
                            ],
                              children: [
                                Gap(20.h),
                                DefaultText(
                                  data: AppStrings.animalNameAndImageTitle,
                                  fontFamily: "Geist",
                                  fontWeight: FontWeight.w900,
                                  textColor: AppColors.lime,
                                  fontSize: 20.sp,
                                  letterSpacing: -0.41,
                                  lineHeight: 1.33,
                                  textAlign: TextAlign.center,
                                ).animate(delay: 100.ms)
                                    .slide(
                                  begin: const Offset(0, -0.3),
                                  end: const Offset(0, 0), // End at center
                                  duration: 600.ms,
                                  curve: Curves.easeOutBack,
                                )
                                    .fade(begin: 0, end: 1, duration: 600.ms),
                                Gap(4.h),
                                DefaultText(
                                  data: AppStrings.animalNameAndImageMessage,
                                  fontFamily: "Geist",
                                  fontWeight: FontWeight.w400,
                                  textColor: AppColors.white,
                                  fontSize: 16.sp,
                                  letterSpacing: -0.41,
                                  lineHeight: 1.33,
                                  textAlign: TextAlign.center,
                                ).animate()
                                    .slide(
                                  begin: const Offset(0, -0.3),
                                  end: const Offset(0, 0), // End at center
                                  duration: 600.ms,
                                  curve: Curves.easeOutBack,
                                )
                                    .fade(begin: 0, end: 1, duration: 600.ms),
                                Gap(0.1.sh),
                                CaptureImage(
                                  onImageTap: () async {
                                   var file =  await vm.captureAndCropImage(source: ImageSource.camera);
                                   if(file != null) {
                                     setState(() {
                                       imageFile = file;
                                     });
                                     vm.imageUrl = imageFile!.path;
                                   }
                                  },
                                  imagePath: imageFile!.path,
                                ),
                                Gap(12.h),
                                DefaultText(
                                  data: AppStrings.captureImage,
                                  fontFamily: "Geist",
                                  fontWeight: FontWeight.w400,
                                  textColor: AppColors.green,
                                  fontSize: 12.sp,
                                  letterSpacing: -0.41,
                                  lineHeight: 1.33,
                                  textAlign: TextAlign.center,
                                ),
                                Gap(12.h),
                                InputField(
                                  controller: nameCtrl,
                                  title: "What is the common name of the animal sighted?",
                                  hintText: "Enter response here",
                                  validator: (value) {
                                    if(value == null) {
                                      return "Name input field must not be empty";
                                    }
                                    return null;
                                  },
                                ),
                                Gap(40.h),
                                DefaultButton(
                                    btnColor: AppColors.green5C,
                                    isNull: imageFile == null,
                                    btnTextColor: AppColors.mainBlack,
                                    onBtnTap: (){
                                      if(imageFile == null) {
                                        locator<DialogService>().showSnackBar("Image Error", "An image must be taken before proceeding");
                                        return;
                                      }
                                      if(_formKey.currentState!.validate()) {
                                        vm.animalName = nameCtrl.text;
                                        Get.to(()=> const AnimalActivity());
                                      }

                                    }, btnText: AppStrings.next),
                              ],
                          )
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
          ),
        );
      }
    );
  }
}
