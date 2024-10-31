import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:golf_app/core/theme/text_styles.dart';
import 'package:golf_app/features/shared/widgets/point_reward.dart';
import 'package:golf_app/features/topup/view/get_points_page.dart';
import 'package:golf_app/features/topup/view/topup_history_page.dart';

class TopupView extends StatefulWidget {
  const TopupView({super.key});

  @override
  State<TopupView> createState() => _TopupViewState();
}

class _TopupViewState extends State<TopupView> {
  List<String> topupImages = [
    'assets/temp/5000.png',
    'assets/temp/16000.png',
    'assets/temp/25000.png',
  ];
  List<int> topupAmounts = [
    5000,
    16000,
    25000,
  ];

  List<int> topupPrices = [
    149,
    349,
    559,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: Material(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TopupHistoryPage()));
                  },
                  child: SizedBox(
                    width: 56.h,
                    height: 56.h,
                    child: Padding(
                      padding: EdgeInsets.all(12.h),
                      child: SvgPicture.asset(
                        Assets.icHistory,
                        fit: BoxFit.contain,
                        colorFilter: const ColorFilter.mode(
                          AppColors.cardTitleDark,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.page_title_topup,
              style: AppTextStyles.title32(context),
            ),
            SizedBox(height: 12.h),
            PointReward(
              showGoToTopupPageIcon: false,
              onPointRewardClicked: () {},
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 475.h,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: List.generate(
                  topupImages.length,
                  (index) => Column(
                    children: [
                      if (index != 0) SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetPointsPage(
                                        topupImage: topupImages[index],
                                        topupAmount: topupAmounts[index],
                                        topupPrice: topupPrices[index],
                                      )));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 113.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.itemStroke),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 12.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // image
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6.r),
                                      child: Image.asset(
                                        topupImages[index],
                                        width: 96.w,
                                        height: 89.h,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // amount
                                        Text(
                                          AppLocalizations.of(context)!
                                                  .text_topup_get +
                                              topupAmounts[index].toString() +
                                              AppLocalizations.of(context)!
                                                  .text_topup_points,
                                          style: AppTextStyles
                                                  .descriptionBold16(context)
                                              .copyWith(
                                                  color:
                                                      AppColors.cardTitleDark),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          AppLocalizations.of(context)!
                                                  .text_topup_buy +
                                              topupAmounts[index].toString() +
                                              AppLocalizations.of(context)!
                                                  .text_topup_points_with_one_click,
                                          style: AppTextStyles
                                                  .descriptionRegular12(context)
                                              .copyWith(
                                                  color: AppColors
                                                      .itemDescriptionLight),
                                        ),
                                        SizedBox(height: 12.h),
                                        // price
                                        Container(
                                          height: 24.h,
                                          decoration: BoxDecoration(
                                            color: AppColors
                                                .cardBackgroundSecondary,
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            border: Border.all(
                                                color: AppColors.itemStroke),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w,
                                                vertical: 4.5.h),
                                            child: Text(
                                              '${topupPrices[index]}\$',
                                              style: AppTextStyles
                                                      .descriptionBold12(
                                                          context)
                                                  .copyWith(
                                                      color:
                                                          AppColors.priceText,
                                                      height: 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // nevigate to icon
                                CircleAvatar(
                                  radius: 12.h,
                                  backgroundColor:
                                      AppColors.buttonBackgroundSecondary,
                                  child: SvgPicture.asset(
                                    Assets.icRightArrow,
                                    height: 12.h,
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
