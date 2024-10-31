import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';

class LocationsItem extends StatefulWidget {
  const LocationsItem({
    super.key,
    required this.name,
    required this.value,
  });
  final String name;
  final bool value;

  @override
  State<LocationsItem> createState() => _LocationsItemState();
}

class _LocationsItemState extends State<LocationsItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: Row(
        children: [
          SizedBox(width: 8.w),
          SizedBox(
            width: 40.w,
            height: 24.h,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: widget.value,
                onChanged: (v) {},
                side: const BorderSide(color: AppColors.cardTitleHighlight),
                checkColor: Colors.white,
                activeColor:AppColors.cardTitleHighlight,
                
              ),
            ),
          ),
          Text(
            widget.name,
            style: AppTextStyles.descriptionRegular16(context)
                .copyWith(color: AppColors.cardTitleDark),
          ),
        ],
      ),
    );
  }
}
