import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookedListItem extends StatelessWidget {
  const BookedListItem({
    super.key,
    required this.name,
    required this.isExpired,
    required this.playerCount,
  });
  final String name;
  final bool isExpired;
  final int playerCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.itemStroke),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              SizedBox(height: 12.h), // Padding
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: SizedBox(
                      width: 96.w,
                      height: 89.h,
                      child: Image.asset(
                        'assets/temp/place_temp_1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      // course name
                      Text(
                        name,
                        style: AppTextStyles.descriptionBold16(context)
                            .copyWith(color: AppColors.cardTitleDark),
                      ),
                      SizedBox(height: 6.h),
                      // booked/expired status
                      Container(
                        height: 24.h,
                        decoration: BoxDecoration(
                          color: isExpired
                              ? AppColors.statusDisabledBackground
                              : AppColors.statusAvailableBackground,
                          border: Border.all(
                            width: 0.4,
                            color: isExpired
                                ? AppColors.statusDisabledStroke
                                : AppColors.statusAvailableStroke,
                          ),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Center(
                            child: Text(
                              isExpired
                                  ? AppLocalizations.of(context)!
                                      .text_bookings_expired
                                  : AppLocalizations.of(context)!
                                      .text_bookings_booked,
                              style: AppTextStyles.descriptionBold12(context)
                                  .copyWith(
                                      color: isExpired
                                          ? AppColors.statusDisabledText
                                          : AppColors.statusAvailableText),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // date and time
                      Row(
                        children: [
                          SizedBox(
                            width: 16.h,
                            height: 16.h,
                            child: SvgPicture.asset(
                              Assets.icCalendar,
                              colorFilter: ColorFilter.mode(
                                isExpired ? AppColors.inputIconSecondary : AppColors.cardTitleHighlight,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '14.10.2024 | 07:30',
                            style: AppTextStyles.descriptionRegular12(context)
                                .copyWith(color: AppColors.itemDescriptionLight),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      // player count
                      Row(
                        children: [
                          SizedBox(
                            width: 16.h,
                            height: 16.h,
                            child: SvgPicture.asset(
                              Assets.icPeople,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                isExpired ? AppColors.inputIconSecondary : AppColors.cardTitleHighlight,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '$playerCount ${AppLocalizations.of(context)!.text_bookings_player_s}',
                            style: AppTextStyles.descriptionRegular12(context)
                                .copyWith(color: AppColors.itemDescriptionLight),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      // location / km m away
                      Row(
                        children: [
                          SizedBox(
                            width: 16.h,
                            height: 16.h,
                            child: SvgPicture.asset(
                              Assets.icLocation,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                isExpired ? AppColors.inputIconSecondary : AppColors.cardTitleHighlight,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '456m away',
                            style: AppTextStyles.descriptionRegular12(context)
                                .copyWith(color: AppColors.itemDescriptionLight),
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            width: 4.h,
                            height: 4.h,
                            decoration: const BoxDecoration(
                              color: Color(0xffD9D9D9),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          SizedBox(
                            width: 120.w,
                            child: Text(
                              'Bandar Penawar, Malaysia',
                              style: AppTextStyles.descriptionRegular12(context)
                                  .copyWith(
                                      color: AppColors.itemDescriptionLight),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                width: double.infinity,
                height: 1.h,
                color: AppColors.cardStroke,
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.text_bookings_see_details,
                    style: AppTextStyles.desciptionSemiBold16(context)
                        .copyWith(color: AppColors.cardTitleHighlight),
                  ),
                  Container(
                    width: 24.h,
                    height: 24.h,
                    decoration: const BoxDecoration(
                      color: AppColors.buttonBackgroundSecondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 16.h,
                        height: 16.h,
                        child: SvgPicture.asset(
                          Assets.icRightArrow,
                          fit: BoxFit.cover,
                          colorFilter: const ColorFilter.mode(
                            AppColors.inputIconSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h), // Padding
            ],
          ),
        ),
      ),
    );
  }
}
