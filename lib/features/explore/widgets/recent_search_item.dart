import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';

class RecentSearchItem extends StatelessWidget {
  const RecentSearchItem({
    super.key,
    required this.searchString,
    required this.onRecentTap,
    required this.onDelete,
  });
  final String searchString;
  final VoidCallback onDelete;
  final VoidCallback onRecentTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onRecentTap,
          child: SizedBox(
            height: 56.h,
            child: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 280.w,
                    child: Text(
                      searchString,
                      style: AppTextStyles.descriptionRegular16(context)
                          .copyWith(color: AppColors.cardTitleDark),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: Material(
                      child: InkWell(
                        onTap: onDelete,
                        child: SizedBox(
                          width: 24.h,
                          height: 24.h,
                          child: SvgPicture.asset(
                            Assets.icClose,
                            width: 16.h,
                            height: 16.h,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1.h,
          color: AppColors.listStroke,
        ),
      ],
    );
  }
}
