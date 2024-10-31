import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';
import 'package:golf_app/features/explore/widgets/locations_item.dart';
import 'package:golf_app/features/shared/widgets/custom_button.dart';

class ExploreFilterLocationsView extends StatefulWidget {
  const ExploreFilterLocationsView({super.key});

  @override
  State<ExploreFilterLocationsView> createState() =>
      _ExploreFilterLocationsViewState();
}

class _ExploreFilterLocationsViewState
    extends State<ExploreFilterLocationsView> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: Material(
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
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.text_filter_locations,
          style: AppTextStyles.title20(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 1.h,
            color: AppColors.listStroke,
          ),
          SizedBox(
            height: 635.h,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: 20,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                            value = !value;
                          });
                },
                child: AbsorbPointer(
                  child: Column(
                    children: [
                      if (index != 0)
                        Container(
                          width: double.infinity,
                          height: 1.h,
                          color: AppColors.listStroke,
                        ),
                      SizedBox(height: 8.h),
                      LocationsItem(
                        name: 'George Town',
                        value: value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CustomButton(
              height: 64.h,
              backgroundColor: AppColors.buttonBackgroundPrimary,
              text: AppLocalizations.of(context)!.text_filter_apply,
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
    );
  }
}
