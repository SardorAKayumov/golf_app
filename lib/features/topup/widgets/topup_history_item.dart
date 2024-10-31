import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopupHistoryItem extends StatefulWidget {
  const TopupHistoryItem({super.key});

  @override
  State<TopupHistoryItem> createState() => _TopupHistoryItemState();
}

class _TopupHistoryItemState extends State<TopupHistoryItem> {
  bool isExpanded = false;
  int animationDuration = 200;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: animationDuration),
        width: double.infinity,
        height: isExpanded ? 106.h : 75.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.itemStroke),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '+5000${AppLocalizations.of(context)!.text_topup_points}',
                    style: AppTextStyles.descriptionBold16(context).copyWith(
                        color: AppColors.cardTitleHighlight, height: 1.2),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: animationDuration),
                    height: isExpanded ? 12.h : 4.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '14.10.2024',
                        style: AppTextStyles.descriptionRegular12(context)
                            .copyWith(color: AppColors.itemDescriptionLight),
                      ),
                      AnimatedOpacity(
                        opacity: isExpanded ? 1.0 : 0.0,
                        duration: Duration(milliseconds: animationDuration),
                        child: Text(
                          ' | 22:31',
                          style: AppTextStyles.descriptionRegular12(context)
                              .copyWith(color: AppColors.itemDescriptionLight),
                        ),
                      ),
                    ],
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: animationDuration),
                    height: isExpanded ? 4.h : 0.h,
                  ),
                  AnimatedOpacity(
                    opacity: isExpanded ? 1.0 : 0.0,
                    duration: Duration(milliseconds: animationDuration),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: animationDuration),
                      height: isExpanded ? 19.h : 0.h,
                      child: Text(
                        'MASTERCARD ****1234',
                        style: AppTextStyles.descriptionRegular12(context)
                            .copyWith(color: AppColors.itemDescriptionLight),
                      ),
                    ),
                  ),
                ],
              ),
              // expand button
              CircleAvatar(
                radius: 12.h,
                backgroundColor: AppColors.buttonBackgroundSecondary,
                child: SvgPicture.asset(
                  isExpanded ? Assets.icUpArrow : Assets.icDownArrow,
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
