import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTextStyles {
  static TextStyle title20(BuildContext context) => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.cardTitleDark,
      );
  static TextStyle title24(BuildContext context) => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.cardTitleDark,
      );
  static TextStyle title32(BuildContext context) => TextStyle(
        fontSize: 32.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.cardTitleDark,
      );
  static TextStyle title40(BuildContext context) => TextStyle(
        fontSize: 40.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.cardTitleDark,
      );
  static TextStyle title48(BuildContext context) => TextStyle(
        fontSize: 48.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.cardTitleDark,
      );

  static TextStyle descriptionRegular12(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle desciptionSemiBold12(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.04 * 12.sp,
      );
  static TextStyle descriptionBold12(BuildContext context) => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle descriptionRegular16(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle desciptionSemiBold16(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.04 * 16.sp,
      );
  static TextStyle descriptionBold16(BuildContext context) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.03 * 16.sp,
      );
  static TextStyle descriptionMedium24(BuildContext context) => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.02 * 24.sp,
      );
}
