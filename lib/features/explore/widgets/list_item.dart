import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/features/course/view/course_page.dart';

import '../../../core/constants/assets.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExploreListItem extends StatelessWidget {
  const ExploreListItem({
    super.key,
    required this.price,
    required this.name,
    required this.image,
    required this.isDiscount,
  });

  final int price;
  final String name;
  final String image;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CourseDetailsPage(images: [
                          'assets/temp/place_temp_1.png',
                          'assets/temp/place_temp_2.png',
                          'assets/temp/place_temp_4.png',
                        ])));
          },
          child: Container(
            width: double.infinity,
            height: 113.h,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.inputStroke),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: SizedBox(
                      width: 96.w,
                      height: 89.h,
                      child: Image.asset(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 222.w,
                        child: Text(
                          name,
                          style: AppTextStyles.descriptionBold16(context)
                              .copyWith(color: AppColors.cardTitleDark),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.priceBackground,
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: AppColors.priceStroke,
                                width: 0.4,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 4.5.h),
                              child: Text(
                                '${price}\$',
                                style: AppTextStyles.descriptionBold12(context)
                                    .copyWith(color: AppColors.priceText),
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            decoration: BoxDecoration(
                              color: isDiscount
                                  ? AppColors.discountBackground
                                  : AppColors.statusAvailableBackground,
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: isDiscount
                                    ? AppColors.discountStroke
                                    : AppColors.statusAvailableStroke,
                                width: 0.4,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 4.5.h),
                              child: Text(
                                isDiscount
                                    ? AppLocalizations.of(context)!
                                        .text_price_discount
                                    : AppLocalizations.of(context)!
                                        .text_price_available,
                                style: AppTextStyles.descriptionBold12(context)
                                    .copyWith(
                                        color: isDiscount
                                            ? AppColors.discountText
                                            : AppColors.statusAvailableText),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          SvgPicture.asset(
                            Assets.icLocation,
                            color: AppColors.cardDescriptionLight,
                            width: 16.h,
                            height: 16.h,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '467m away',
                            style: AppTextStyles.descriptionRegular12(context)
                                .copyWith(
                                    color: AppColors.cardDescriptionLight),
                          ),
                          SizedBox(width: 4.w),
                          CircleAvatar(
                            radius: 2.h,
                            backgroundColor: AppColors.cardDescriptionLight,
                          ),
                          SizedBox(width: 4.w),
                          SizedBox(
                            width: 110.w,
                            child: Text(
                              'Bandar Penawar, Malaysia',
                              style: AppTextStyles.descriptionRegular12(context)
                                  .copyWith(
                                      color: AppColors.cardDescriptionLight),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
