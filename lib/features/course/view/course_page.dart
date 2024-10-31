import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/text_styles.dart';
import 'package:golf_app/features/booking/booking.dart';
import 'package:golf_app/features/shared/widgets/custom_button.dart';

import '../../../core/theme/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseDetailsPage extends StatefulWidget {
  const CourseDetailsPage({super.key, required this.images});
  final List<String> images;
  final String name = 'The Els Club Desaru Coast';
  final bool isDiscount = false;
  final int price = 120;
  final String location = 'Bandar Penawar';
  final double distance = 1.3;
  final String about =
      'A gym, short for gymnasium, is a facility dedicated to physical fitness and exercise. It typically offers a variety of equipment and activities for people to improve their strength, endurance, flexibility, and overall health';
  final List<String> amenities = const [
    'Free Wifi',
    'Dining',
    'Free Wifi',
    'Dining',
  ];

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  final PageController _imagesController = PageController();
  final ScrollController _scrollController = ScrollController();
  int _currentImageIndex = 0;

  bool doReadMore = false;
  bool doShowAll = false;

  @override
  void initState() {
    super.initState();
    _imagesController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _imagesController.removeListener(_onScroll);
    _imagesController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _currentImageIndex = _imagesController.page!.round();
    });
  }

  void onReadMore() {
    setState(() {
      doReadMore = !doReadMore;
    });
  }

  void onShowAll() {
    setState(() {
      doShowAll = !doShowAll;
    });

    if (doShowAll) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Images
          SizedBox(
            height: 300.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  controller: _imagesController,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      widget.images[index],
                      fit: BoxFit.fitHeight,
                    );
                  },
                ),
                // back button
                Positioned(
                  left: 12.w,
                  top: 66.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset(
                          Assets.icLeftArrow,
                          width: 32.h,
                          height: 32.h,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // index indicator
                if (widget.images.isNotEmpty && widget.images.length > 1)
                  Positioned(
                    bottom: 36.w,
                    child: Row(
                      children: List.generate(
                        widget.images.length,
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: index == _currentImageIndex
                                  ? Colors.white
                                  : const Color(0x4DFFFFFF),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Bottom form
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 567.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Stack(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 442.h),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 24.h),
                            Text(
                              widget.name,
                              style: AppTextStyles.title20(context),
                            ),
                            SizedBox(height: 8.h),
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
                                      style: AppTextStyles.descriptionBold12(
                                              context)
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
                                      style: AppTextStyles.descriptionBold12(
                                              context)
                                          .copyWith(
                                              color: widget.isDiscount
                                                  ? AppColors.discountText
                                                  : AppColors.statusAvailableText),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.icLocation,
                                  width: 24.h,
                                  height: 24.h,
                                  fit: BoxFit.none,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.itemDescriptionLight,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  widget.location,
                                  style: AppTextStyles.desciptionSemiBold16(
                                          context)
                                      .copyWith(
                                          color:
                                              AppColors.itemDescriptionLight),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.icMapArrow,
                                  width: 24.h,
                                  height: 24.h,
                                  fit: BoxFit.none,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.itemDescriptionLight,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  widget.distance.toString() +
                                      AppLocalizations.of(context)!
                                          .text_course__km_from_you,
                                  style: AppTextStyles.desciptionSemiBold16(
                                          context)
                                      .copyWith(
                                          color:
                                              AppColors.itemDescriptionLight),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            // About
                            Text(
                              AppLocalizations.of(context)!.text_general_about,
                              style: AppTextStyles.descriptionBold16(context)
                                  .copyWith(color: AppColors.cardTitleDark),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              widget.about,
                              style: AppTextStyles.descriptionRegular16(context)
                                  .copyWith(
                                      color: AppColors.itemDescriptionLight),
                              maxLines: doReadMore ? 100 : 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4.r),
                              child: Material(
                                child: InkWell(
                                  onTap: onReadMore,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .text_general_read_more,
                                        style: AppTextStyles.desciptionSemiBold16(
                                                context)
                                            .copyWith(
                                                color: AppColors.textButtonActive,
                                                letterSpacing: -0.3),
                                      ),
                                      SvgPicture.asset(
                                        doReadMore ? Assets.icUpArrow :
                                        Assets.icDownArrow,
                                        width: 18.h,
                                        height: 18.h,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.textButtonActive,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // Course amenities
                            if (widget.amenities.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .text_course_amenities,
                                    style:
                                        AppTextStyles.descriptionBold16(context)
                                            .copyWith(
                                                color: AppColors.cardTitleDark),
                                  ),
                                  SizedBox(height: 8.h),
                                  Column(
                                    children: List.generate(
                                      doShowAll
                                          ? widget.amenities.length
                                          : widget.amenities.length != 1
                                              ? 2
                                              : 1,
                                      (index) => Row(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.icPlus,
                                            width: 24.h,
                                            height: 24.h,
                                            fit: BoxFit.none,
                                            colorFilter: const ColorFilter.mode(
                                              AppColors.itemDescriptionLight,
                                              BlendMode.srcIn,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            widget.amenities[index],
                                            style: AppTextStyles
                                                    .desciptionSemiBold16(
                                                        context)
                                                .copyWith(
                                                    color: AppColors
                                                        .itemDescriptionLight),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  if (widget.amenities.length > 2)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.r),
                                    child: Material(
                                      child: InkWell(
                                        onTap: onShowAll,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .text_general_show_all,
                                              style: AppTextStyles
                                                      .desciptionSemiBold16(
                                                          context)
                                                  .copyWith(
                                                      color: AppColors
                                                          .textButtonActive),
                                            ),
                                            SvgPicture.asset(
                                              doShowAll
                                                  ? Assets.icUpArrow
                                                  : Assets.icDownArrow,
                                              width: 18.h,
                                              height: 18.h,
                                              fit: BoxFit.none,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                AppColors.textButtonActive,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                          ],
                                        ),
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h),
                      child: CustomButton(
                        height: 64.h,
                        backgroundColor: AppColors.textButtonActive,
                        text: AppLocalizations.of(context)!.text_check_tee_time,
                        textStyle: AppTextStyles.title24(context)
                            .copyWith(color: Colors.white),
                        borderRadius: 12.r,
                        width: double.infinity,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TeeTimesPage()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
