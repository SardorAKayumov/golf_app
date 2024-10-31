import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';

class CreditCardsListItem extends StatefulWidget {
  const CreditCardsListItem({
    super.key,
    required this.isSelected,
    required this.onCreditSelected,
  });
  final bool isSelected;
  final VoidCallback onCreditSelected;

  @override
  State<CreditCardsListItem> createState() => _CreditCardsListItemState();
}

class _CreditCardsListItemState extends State<CreditCardsListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCreditSelected,
      child: Container(
        width: double.infinity,
        height: 78.h,
        decoration: BoxDecoration(
          border: Border.all(
              color: widget.isSelected
                  ? AppColors.cardTitleHighlight
                  : AppColors.cardStroke),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 24.h,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: AppColors.radioBackgroundEmpty,
                      border: Border.all(
                        color: widget.isSelected
                            ? AppColors.cardTitleHighlight
                            : AppColors.radioStroke,
                        width: widget.isSelected ? 2 : 1,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: widget.isSelected
                        ? Center(
                            child: Container(
                              width: 12.h,
                              height: 12.h,
                              decoration: const BoxDecoration(
                                color: AppColors.cardTitleHighlight,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
                  ),
                  SizedBox(width: 16.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: SizedBox(
                      width: 64.w,
                      height: 40.h,
                      child: Image.asset(
                        'assets/temp/credit_card.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 155.w,
                        child: Text(
                          'John Doe',
                          style: AppTextStyles.desciptionSemiBold16(context)
                              .copyWith(color: AppColors.cardTitleDark),
                              overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        width: 155.w,
                        child: Text(
                          'VISA ****1234',
                          style: AppTextStyles.desciptionSemiBold12(context)
                              .copyWith(color: AppColors.cardDescription300),
                              overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 36.h,
                height: 36.h,
                child: Image.asset(
                  'assets/temp/visa_small.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
