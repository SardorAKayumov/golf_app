import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';
import 'package:golf_app/features/shared/widgets/custom_appbar.dart';
import 'package:golf_app/features/shared/widgets/custom_button.dart';
import 'package:golf_app/features/topup/topup.dart';
import 'package:golf_app/features/topup/view/add_card_page.dart';
import 'package:golf_app/injection_handler.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GetPointsPage extends StatefulWidget {
  const GetPointsPage({
    super.key,
    required this.topupImage,
    required this.topupAmount,
    required this.topupPrice,
  });
  final String topupImage;
  final int topupAmount;
  final int topupPrice;

  @override
  State<GetPointsPage> createState() => _GetPointsPageState();
}

class _GetPointsPageState extends State<GetPointsPage> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<TopupBloc>(),
      child: Scaffold(
        appBar: CustomAppBar(
          context: context,
          title: AppLocalizations.of(context)!.page_title_get_points,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: List.generate(
                          2,
                          (index) => Column(
                            children: [
                              SizedBox(height: 8.h),
                              CreditCardsListItem(
                                isSelected: _selectedIndex == index,
                                onCreditSelected: () {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 19.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddCardPage()));
                      },
                      child: SizedBox(
                        width: 342.w,
                        height: 64.h,
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                Assets.icPlus,
                                width: 24.h,
                                height: 24.h,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.cardTitleHighlight,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                AppLocalizations.of(context)!
                                    .text_topup_add_new_card,
                                style: AppTextStyles.title20(context)
                                    .copyWith(
                                        color:
                                            AppColors.cardTitleHighlight),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 36.h),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 192.h,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 1.h,
                    color: AppColors.cardStroke,
                  ),
                  // Topup detail
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 72.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6.r),
                              child: SizedBox(
                                width: 52.w,
                                height: 48.h,
                                child: Image.asset(
                                  widget.topupImage,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.text_topup_get +
                                      widget.topupAmount.toString() +
                                      AppLocalizations.of(context)!
                                          .text_topup_points,
                                  style:
                                      AppTextStyles.descriptionBold16(context)
                                          .copyWith(
                                              color: AppColors.cardTitleDark),
                                ),
                                SizedBox(height: 3.h),
                                Container(
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.cardBackgroundSecondary,
                                    borderRadius: BorderRadius.circular(4.r),
                                    border:
                                        Border.all(color: AppColors.itemStroke),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 4.5.h),
                                    child: Text(
                                      '${widget.topupPrice}\$',
                                      style: AppTextStyles.descriptionBold12(
                                              context)
                                          .copyWith(
                                              color: AppColors.priceText,
                                              height: 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 19.h),
                  // proceed button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: CustomButton(
                      height: 64.h,
                      backgroundColor: AppColors.buttonBackgroundPrimary,
                      text:
                          '${widget.topupPrice}\$ ${AppLocalizations.of(context)!.text_to_proceed}',
                      textStyle: AppTextStyles.title20(context)
                          .copyWith(color: Colors.white),
                      borderRadius: 8.r,
                      width: double.infinity,
                      onTap: () {},
                      svgIcon: Assets.icRightArrow,
                    ),
                  ),
                  SizedBox(height: 36.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
