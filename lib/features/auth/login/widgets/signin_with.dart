import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/colors.dart';

class SignInWithWidget extends StatelessWidget {
  final String asset;
  final VoidCallback onTap;
  const SignInWithWidget({
    super.key,
    required this.asset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 64.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.buttonStroke),
            ),
            child: SvgPicture.asset(
              asset,
              width: 24.h,
              height: 24.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
