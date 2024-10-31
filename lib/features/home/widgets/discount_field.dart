import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:golf_app/features/course/view/course_page.dart';

class DiscountField extends StatefulWidget {
  final String name;
  final List<String> images;
  final int price;
  final bool isDiscount;
  const DiscountField({
    super.key,
    required this.name,
    required this.images,
    required this.price,
    required this.isDiscount,
  });

  @override
  State<DiscountField> createState() => _DiscountFieldState();
}

class _DiscountFieldState extends State<DiscountField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
        height: 292.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.inputStroke),
        ),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            SizedBox(
              height: 162.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  widget.images.length,
                  (index) => Row(
                    children: [
                      if (index == 0) SizedBox(width: 10.w),
                      SizedBox(width: 6.w),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: SizedBox(
                          width: 260.w,
                          height: 162.h,
                          child: Image.asset(
                            widget.images[index],
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      if (index == widget.images.length - 1)
                        SizedBox(width: 16.w),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: AppTextStyles.title20(context),
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
                            '${widget.price}\$',
                            style: AppTextStyles.descriptionBold12(context)
                                .copyWith(color: AppColors.priceText),
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        decoration: BoxDecoration(
                          color: widget.isDiscount
                              ? AppColors.discountBackground
                              : AppColors.statusAvailableBackground,
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: widget.isDiscount
                                ? AppColors.discountStroke
                                : AppColors.statusAvailableStroke,
                            width: 0.4,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.5.h),
                          child: Text(
                            widget.isDiscount
                                ? AppLocalizations.of(context)!
                                    .text_price_discount
                                : AppLocalizations.of(context)!
                                    .text_price_available,
                            style: AppTextStyles.descriptionBold12(context)
                                .copyWith(
                                    color: widget.isDiscount
                                        ? AppColors.discountText
                                        : AppColors.statusAvailableText),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.w),
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
                        style: AppTextStyles.descriptionBold12(context)
                            .copyWith(color: AppColors.cardDescriptionLight),
                      ),
                      SizedBox(width: 4.w),
                      CircleAvatar(
                        radius: 2.h,
                        backgroundColor: AppColors.cardDescriptionLight,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Bandar Penawar, Malaysia',
                        style: AppTextStyles.descriptionBold12(context)
                            .copyWith(color: AppColors.cardDescriptionLight),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
