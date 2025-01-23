import 'dart:async';
import 'dart:typed_data';

import 'package:citizen_app/core/presentation/ui/shared_widgets/custom_shape_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../../../constants/app_colors.dart';
import '../../../shared_widgets/default_text.dart';
import 'dart:ui' as ui;

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key, required this.title, required this.imagePath, required this.subtitle});

  final String imagePath;
  final String title;
  final String subtitle;

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  Future<ui.Image>_loadUiImage(String assetPath) async{
    final ByteData data = await rootBundle.load(assetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder<ui.Image>(
          future: _loadUiImage(widget.imagePath),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
              return SizedBox(
                  width: 1.sw,
                  height: 280.h,
                  child: CustomShapeImage(
                image: snapshot.data!,
              )
            ).animate()
                  .slide(
                begin: const Offset(0, -0.2), // Start from top of screen
                end: const Offset(0, 0), // End at center
                duration: 500.ms,
                curve: Curves.easeOutBack,
              )
                  .fade(begin: 0, end: 1, duration: 500.ms);
            }else {
              return const CircularProgressIndicator();
            }
          }
        ),
        Gap(26.h),
        SizedBox(
          width: 290.w,
          child: DefaultText(
            data: widget.title,
            fontFamily: "Geist",
            fontWeight: FontWeight.w900,
            textColor: AppColors.lime,
            fontSize: 32.sp,
            letterSpacing: -0.41,
            lineHeight: 1.33,
            textAlign: TextAlign.center,
          ),
        ).animate(delay: 100.ms)
            .slide(
          begin: const Offset(0, 0.2), // Start from top of screen
          end: const Offset(0, 0), // End at center
          duration: 500.ms,
          curve: Curves.easeOutBack,
        )
            .fade(begin: 0, end: 1, duration: 500.ms),
        Gap(10.h),
        SizedBox(
          width: 267.w,
          child: DefaultText(
            data: widget.subtitle,
            fontFamily: "Geist",
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
            fontSize: 16.sp,
            letterSpacing: -0.41,
            lineHeight: 1.33,
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ).animate(delay: 150.ms)
            .slide(
          begin: const Offset(0, 0.2), // Start from top of screen
          end: const Offset(0, 0), // End at center
          duration: 500.ms,
          curve: Curves.easeOutBack,
        )
            .fade(begin: 0, end: 1, duration: 500.ms)
      ],
    );
  }
}
