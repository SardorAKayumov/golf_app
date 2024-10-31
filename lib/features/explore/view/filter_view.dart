import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:golf_app/features/explore/view/locations_view.dart';
import 'package:golf_app/features/shared/widgets/custom_button.dart';

class ExploreFilterView extends StatefulWidget {
  const ExploreFilterView({super.key});

  @override
  State<ExploreFilterView> createState() => _ExploreFilterViewState();
}

class _ExploreFilterViewState extends State<ExploreFilterView> {
  bool _isLowerPriceFilterOn = false;
  String location = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: Material(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          AppLocalizations.of(context)!.text_general_reset,
                          style: AppTextStyles.descriptionBold16(context)
                              .copyWith(color: AppColors.textButtonActive),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.text_filters,
                    style: AppTextStyles.title20(context),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      Assets.icClose,
                      width: 32.h,
                      height: 32.h,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              height: 1.h,
              color: AppColors.inputStroke,
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .text_filter_lower_price_First,
                        style: AppTextStyles.descriptionBold16(context)
                            .copyWith(color: Colors.black),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.5.h),
                        child: SizedBox(
                          width: 51.h,
                          height: 31.h,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: CupertinoSwitch(
                              value: _isLowerPriceFilterOn,
                              onChanged: (value) {
                                setState(() {
                                  _isLowerPriceFilterOn = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    height: 64.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.inputStroke),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .text_filter_by_location,
                            style: AppTextStyles.descriptionBold16(context)
                                .copyWith(color: AppColors.cardTitleDark),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: Material(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ExploreFilterLocationsView()));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .text_filter_location_select,
                                      style: AppTextStyles.descriptionBold16(
                                              context)
                                          .copyWith(
                                              color:
                                                  AppColors.textButtonActive),
                                    ),
                                    SizedBox(width: 4.w),
                                    SizedBox(
                                      width: 24.h,
                                      height: 24.h,
                                      child: SvgPicture.asset(
                                        Assets.icRightArrow,
                                        width: 8.h,
                                        height: 14.h,
                                        colorFilter: const ColorFilter.mode(
                                            AppColors.textButtonActive,
                                            BlendMode.srcIn),
                                        fit: BoxFit.none,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 482.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomButton(
                height: 64.h,
                backgroundColor: AppColors.buttonBackgroundPrimary,
                text: AppLocalizations.of(context)!.text_filter_show_results,
                textStyle:
                    AppTextStyles.title24(context).copyWith(color: Colors.white),
                borderRadius: 12.r,
                width: double.infinity,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
