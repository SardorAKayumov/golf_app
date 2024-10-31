import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import '../../../core/constants/assets.dart';
import '../../../core/theme/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointReward extends StatelessWidget {
  const PointReward({
    super.key,
    required this.showGoToTopupPageIcon,
    required this.onPointRewardClicked,
  });

  final bool showGoToTopupPageIcon;
  final VoidCallback onPointRewardClicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showGoToTopupPageIcon) {
          onPointRewardClicked();
        }
      },
      child: Container(
        width: double.infinity,
        height: 85.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.inputStroke, width: 0.6),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24.h,
                    backgroundColor: AppColors.radioBackgroundEmpty,
                    child: SvgPicture.asset(
                      Assets.icStar,
                      width: 24.h,
                      height: 24.h,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.text_home_point_rewards,
                          style: AppTextStyles.descriptionBold16(context)
                              .copyWith(
                                  color: AppColors.cardTitleDark, height: 1),
                        ),
                        Text(
                          '500',
                          style: AppTextStyles.title32(context).copyWith(
                              color: const Color(0xffFFD400), height: 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (showGoToTopupPageIcon)
                CircleAvatar(
                  radius: 12.h,
                  backgroundColor: AppColors.buttonBackgroundSecondary,
                  child: SvgPicture.asset(
                    Assets.icRightArrow,
                    height: 12.h,
                    fit: BoxFit.none,
                    colorFilter: const ColorFilter.mode(
                      AppColors.inputIconSecondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
