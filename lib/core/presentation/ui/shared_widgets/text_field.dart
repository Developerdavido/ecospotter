import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../constants/app_colors.dart';
import 'custom_text_formfield.dart';
import 'default_text.dart';


class InputField extends StatefulWidget {
  const InputField({
    required this.controller,
    super.key,
    this.suffixIcon,
    this.countryCodeController,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.defaultValidation = true,
    this.inputFormatters,
    this.prefix,
    this.title,
    this.enabled = true,
    this.readOnly = false,
    this.contentPadding,
    this.prefixIcon,
    this.focusNode,
    this.onTap,
    this.expandable = false,
    this.labelText,
  });

  final Widget? suffixIcon;
  final String? hintText;
  final String? title;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  final TextEditingController? countryCodeController;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool defaultValidation;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefix;
  final bool enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final bool expandable;
  final String? labelText;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.r),
      borderSide: const BorderSide(
        color: AppColors.buttonBorder,
        width: 0.5,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultText(
          data: widget.title ?? "",
          fontWeight: FontWeight.w400,
          textColor: AppColors.greyE3,
          fontSize: 14.sp,
          letterSpacing: -0.48,
          lineHeight: 1.2,
        ),
        Gap(6.h),
        Expanded(
          child: CustomTextField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            readOnly: widget.readOnly,
            expandable: widget.expandable,
            onTap: widget.onTap,
            hintText: widget.hintText,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
            prefix: widget.prefix,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            defaultValidation: widget.defaultValidation,
          ),
        )
      ],
    );
  }
}