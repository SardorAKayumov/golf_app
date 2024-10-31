import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

class AuthInputField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String hintText;
  final String prefixIconAsset;
  final String suffixIconAsset;
  final String? suffixIconAssetOff;
  final bool canBeObscure;
  final bool isValid;
  final VoidCallback onTapSuffixIcon;
  final VoidCallback onTextChanged;
  const AuthInputField({
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.prefixIconAsset,
    required this.suffixIconAsset,
    required this.suffixIconAssetOff,
    required this.canBeObscure,
    required this.isValid,
    required this.onTapSuffixIcon,
    required this.onTextChanged,
  });

  @override
  State<AuthInputField> createState() => _AuthInputFieldState();
}

class _AuthInputFieldState extends State<AuthInputField> {
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      if (widget.controller.text.isEmpty) {
        isObscure = true;
      }
    });
    widget.onTextChanged();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.canBeObscure ? isObscure : false,
      obscuringCharacter: '●',
      style: AppTextStyles.descriptionRegular16(context)
          .copyWith(color: AppColors.inputText),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.descriptionRegular16(context)
            .copyWith(color: AppColors.inputHint),
        filled: true,
        contentPadding: EdgeInsets.zero,
        fillColor:
            widget.isValid ? Colors.white : AppColors.inputBackgroundError,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 16.w),
              SvgPicture.asset(
                widget.prefixIconAsset,
                height: 24.h,
              ),
              SizedBox(width: 16.w),
              Container(
                height: 24.h,
                width: 1.w,
                color: widget.isValid
                    ? AppColors.inputStroke
                    : AppColors.inputErrorStroke,
              ),
              SizedBox(width: 16.w),
            ],
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              if (widget.suffixIconAssetOff != null &&
                  widget.controller.text.isNotEmpty) {
                isObscure = !isObscure;
              }
            });
            widget.onTapSuffixIcon();
          },
          child: Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: Container(
              height: 36.h,
              width: 36.w,
              color: Colors.transparent,
              child: widget.controller.text.isNotEmpty
                  ? SvgPicture.asset(
                      isObscure
                          ? widget.suffixIconAsset
                          : widget.suffixIconAssetOff ?? widget.suffixIconAsset,
                      height: 16.h,
                      width: 16.h,
                      fit: BoxFit.scaleDown,
                      colorFilter: const ColorFilter.mode(
                          AppColors.inputIconSecondary, BlendMode.srcIn),
                    )
                  : null,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: widget.isValid
                  ? AppColors.inputStroke
                  : AppColors.inputErrorStroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: widget.isValid
                  ? AppColors.inputStroke
                  : AppColors.inputErrorStroke),
        ),
      ),
    );
  }
}
