import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TeeTimeSlotItem extends StatefulWidget {
  const TeeTimeSlotItem({
    super.key,
    required this.hour,
    required this.isExpandedByDefault,
  }) : hourString = hour <= 9 ? '0$hour' : '$hour';
  final int hour;
  final String hourString;
  final bool isExpandedByDefault;

  @override
  State<TeeTimeSlotItem> createState() => _TeeTimeSlotItemState();
}

class _TeeTimeSlotItemState extends State<TeeTimeSlotItem> {
  late bool isExpanded = widget.isExpandedByDefault;
  int? chosenIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: isExpanded ? 96.h : 52.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.5.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 68.w,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  '${widget.hourString}:00',
                  style: AppTextStyles.descriptionMedium24(context)
                      .copyWith(color: AppColors.itemDescriptionLight),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Container(
                width: 297.w,
                height: isExpanded ? 96.h : 52.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isExpanded
                                ? AppLocalizations.of(context)!
                                    .text_booking_time_slots
                                : AppLocalizations.of(context)!
                                    .text_booking_tee_time,
                            style: AppTextStyles.desciptionSemiBold16(context)
                                .copyWith(color: AppColors.cardTitleDark),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: SvgPicture.asset(
                              isExpanded
                                  ? Assets.icUpArrow
                                  : Assets.icDownArrow,
                              width: 24.h,
                              height: 24.h,
                              colorFilter: const ColorFilter.mode(
                                AppColors.cardTitleDark,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isExpanded)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            4,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (chosenIndex == index) {
                                    chosenIndex = null;
                                    return;
                                  }
                                  chosenIndex = index;
                                });
                              },
                              child: Container(
                                width: 61.w,
                                height: 32.h,
                                decoration: BoxDecoration(
                                  color: chosenIndex == index
                                      ? AppColors.textButtonActive
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(
                                      color: chosenIndex == index
                                          ? Colors.transparent
                                          : AppColors.listStroke),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${widget.hourString}:${15 * index}${index == 0 ? '0' : ''}',
                                    style: AppTextStyles.desciptionSemiBold16(
                                            context)
                                        .copyWith(
                                            color: chosenIndex == index
                                                ? Colors.white
                                                : AppColors.cardTitleDark),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
