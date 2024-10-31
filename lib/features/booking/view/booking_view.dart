import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:golf_app/features/booking/widgets/personal_information.dart';
import 'package:golf_app/features/shared/widgets/custom_button.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});
  final pricePerPlayer = 120;

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  int playerCount = 1;

  void decreasePlayerCount() {
    setState(() {
      if (playerCount != 1) {
        playerCount--;
      }
    });
  }

  void increasePlayerCount() {
    setState(() {
      if (playerCount != 4) {
        playerCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackgroundDark,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              Assets.icLeftArrow,
              width: 32.h,
              height: 32.h,
              fit: BoxFit.none,
              colorFilter: const ColorFilter.mode(
                AppColors.cardTitleDark,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.page_title_booking,
          style: AppTextStyles.title20(context),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                // Number of players
                Container(
                  width: double.infinity,
                  height: 143.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.page_title_booking,
                          style: AppTextStyles.title20(context)
                              .copyWith(color: AppColors.cardTitleHighlight),
                        ),
                        Container(
                          width: double.infinity,
                          height: 77.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border(
                              left: BorderSide(
                                  color: AppColors.cardTitleHighlight,
                                  width: 8.w),
                              right: const BorderSide(
                                  color: AppColors.cardTitleHighlight,
                                  width: 0.6),
                              top: const BorderSide(
                                  color: AppColors.cardTitleHighlight,
                                  width: 0.6),
                              bottom: const BorderSide(
                                  color: AppColors.cardTitleHighlight,
                                  width: 0.6),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.w, right: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .text_booking_basic_class,
                                      style: AppTextStyles.descriptionRegular12(
                                              context)
                                          .copyWith(
                                              color:
                                                  AppColors.cardTitleHighlight),
                                    ),
                                    Text(
                                      '${widget.pricePerPlayer * playerCount}\$',
                                      style: AppTextStyles.title20(context),
                                    ),
                                  ],
                                ),
                                // Player Count Changer
                                Container(
                                  width: 84.w,
                                  height: 24.h,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColors.cardStroke),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Row(
                                    children: [
                                      // minus button
                                      InkWell(
                                        onTap: decreasePlayerCount,
                                        child: Container(
                                          width: 22.w,
                                          height: 24.h,
                                          color:
                                              AppColors.cardBackgroundSecondary,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6.w,
                                                vertical: 10.h),
                                            child: Container(
                                              width: 12.w,
                                              height: 2.h,
                                              decoration: BoxDecoration(
                                                color: AppColors.cardStrokeDark,
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 1.w,
                                        color: AppColors.cardStroke,
                                      ),
                                      Container(
                                        width: 36.w,
                                        child: Center(
                                          child: Text(
                                            playerCount.toString(),
                                            style: AppTextStyles
                                                    .descriptionRegular16(
                                                        context)
                                                .copyWith(
                                                    color: AppColors.inputText),
                                          ),
                                        ),
                                      ),
                                      // plus button
                                      InkWell(
                                        onTap: increasePlayerCount,
                                        child: Container(
                                          width: 22.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.cardTitleHighlight,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(4.r),
                                              bottomRight: Radius.circular(4.r),
                                            ),
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              Assets.icPlus,
                                              fit: BoxFit.fill,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                Colors.white,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: [
                        // Personal Information
                        PersonalInformationWidget(
                          title: AppLocalizations.of(context)!
                              .text_booking_personal_information,
                          isOptional: false,
                        ),

                        Column(
                          children: List.generate(
                            playerCount - 1,
                            (index) => Column(
                              children: [
                                SizedBox(height: 16.h),
                                PersonalInformationWidget(
                                  title:
                                      '${AppLocalizations.of(context)!.text_booking_player} - #${index + 2}',
                                  isOptional: true,
                                )
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Add player button
                        if (playerCount < 4)
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: increasePlayerCount,
                            child: SizedBox(
                              width: double.infinity,
                              height: 64.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 24.h,
                                    height: 24.h,
                                    child: SvgPicture.asset(
                                      Assets.icPlus,
                                      fit: BoxFit.cover,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.cardTitleHighlight,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .text_booking_add_player,
                                    style: AppTextStyles.title20(context)
                                        .copyWith(
                                            color:
                                                AppColors.cardTitleHighlight),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        SizedBox(height: 120.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Next Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 104.h,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    SizedBox(height: 4.h),
                    CustomButton(
                      height: 64.h,
                      backgroundColor: AppColors.buttonBackgroundPrimary,
                      text:
                          '${widget.pricePerPlayer * playerCount}\$ ${AppLocalizations.of(context)!.text_to_proceed}',
                      textStyle: AppTextStyles.title20(context)
                          .copyWith(color: Colors.white),
                      borderRadius: 12.r,
                      width: double.infinity,
                      onTap: () {},
                      svgIcon: Assets.icRightArrow,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
