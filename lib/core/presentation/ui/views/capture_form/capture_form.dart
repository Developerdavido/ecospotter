import 'dart:async';
import 'dart:io';

import 'package:citizen_app/config/services/dialog_service.dart';
import 'package:citizen_app/config/services/location_service.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/modal_expandable_custom.dart';
import 'package:citizen_app/core/presentation/ui/shared_widgets/text_field.dart';
import 'package:citizen_app/core/presentation/ui/views/badges/widget/badge_trivia_and_description.dart';
import 'package:citizen_app/core/presentation/ui/views/capture_form/animal_activity_widget.dart';
import 'package:citizen_app/core/presentation/ui/views/capture_form/capture_widgets/capture_image.dart';
import 'package:citizen_app/core/view_models/ai_provider.dart';
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
import '../../../../../utils/utils.dart';
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

  final _dataStreamController = StreamController<Map<String, dynamic>?>.broadcast();
  final FocusScopeNode _focusNode = FocusScopeNode();
  Timer? _debounceTimer;

  String? animalName;
  


  File? imageFile;
  AIVm? aiVm;

  @override
  void initState() {
    // TODO: implement initState
    aiVm = context.read<AIVm>();
    super.initState();
    locator<LocationService>().startListening();
    // change the focus node
   // _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    // If focus is lost (keyboard dismissed)
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 300), () {
        makeTheApiCall();
      });

  }


  @override
  void dispose() {
    // TODO: implement dispose
    _dataStreamController.close();
    locator<LocationService>().stopListening();
    super.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _debounceTimer?.cancel();
  }

  //this will clear the
  void _clearData() {
    _dataStreamController.add(null);
  }

  makeTheApiCall() async {
    // Only make the call if we have some input
    final isInternetPresent = await Utils.isInternetPresent();
    if(!isInternetPresent) return;
    if (animalName == null || animalName!.isEmpty) return;
    //var name = nameCtrl.text.trim();
    Map<String,dynamic>? nameDesc = await aiVm!.getAnimalDescription(animalName!.trim());
    _dataStreamController.add(nameDesc);
  }


  @override
  Widget build(BuildContext context) {
    return Consumer2<CaptureProvider, AIVm>(
      builder: (context, vm, aiVm, child) {
        return GestureDetector(
          onTap: (){
            if(!_focusNode.hasPrimaryFocus){
              _focusNode.unfocus();
            }
            makeTheApiCall();
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.primaryColorWhiteBackground,
              body: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                          floating: false,
                          pinned: true,
                          backgroundColor: AppColors.primaryColorWhiteBackground,
                          elevation: 0,
                          surfaceTintColor: Colors.transparent,
                          leading:  widget.isHome ? null : const DefaultBackButton(
                            iconColor: AppColors.blackOA,
                            icon: CupertinoIcons.back,
                            btnColor: AppColors.primaryColorWhiteBackground,
                          )
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                          child: Form(
                            key: _formKey,
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
                                          textColor: AppColors.mainPrimaryColor,
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
                                          textColor: AppColors.blackOA,
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
                                          imagePath: imageFile?.path,
                                        ),
                                        Gap(12.h),
                                        DefaultText(
                                          data: AppStrings.captureImage,
                                          fontFamily: "Geist",
                                          fontWeight: FontWeight.w400,
                                          textColor: AppColors.blackOA,
                                          fontSize: 12.sp,
                                          letterSpacing: -0.41,
                                          lineHeight: 1.33,
                                          textAlign: TextAlign.center,
                                        ),
                                        Gap(12.h),
                                        InputField(
                                          controller: nameCtrl,
                                          onChanged: (value) {
                                            animalName = value;
                                          },
                                          title: "What is the common name of the animal sighted?",
                                          hintText: "Enter response here",
                                          onEditingComplete: (){
                                            if(!_focusNode.hasPrimaryFocus) {
                                              _focusNode.unfocus();
                                            }
                                            makeTheApiCall();
                                          },

                                          validator: (value) {
                                            if(value == null) {
                                              return "Name input field must not be empty";
                                            }
                                            return null;
                                          },
                                        ),
                                        Gap(40.h),
                                        DefaultButton(
                                            btnColor: AppColors.mainPrimaryColor,
                                            isNull: imageFile == null,
                                            btnTextColor: AppColors.white,
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
                        ),
                      )
                    ],
                  ),
                  //place the custom expandable object here
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ModalExpandableCustom(
                        dataStream: _dataStreamController.stream,
                        collapsedHeight: 0.15.sh,
                        expandedHeight: 0.5.sh,
                        onBackPressed: (){
                          setState(() {
                            animalName = null;
                          });
                        },
                        contentBuilder: (data, isExpanded) {
                          return BadgeTriviaAndDescription(
                            isExpanded: isExpanded,
                            trivia: data['trivia'],
                            description: data['description'],
                            errorMessage: data['message'],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
