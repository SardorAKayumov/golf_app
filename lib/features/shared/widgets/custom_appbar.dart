import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/constants/assets.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    required String title,
    required BuildContext context,
    String? actionIcon,
    VoidCallback? onActionTap,
  }) : super(
          centerTitle: true,
          title: Text(title, style: AppTextStyles.title20(context)),
          leading: Navigator.of(context).canPop()
              ? Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: SvgPicture.asset(
                        Assets.icLeftArrow,
                        width: 24.w,
                        height: 24.w,
                        fit: BoxFit.none,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                )
              : null,
          actions: actionIcon != null
              ? [
                  ClipOval(
                    child: Material(
                      child: SizedBox(
                        width: 48.h,
                        height: 48.h,
                        child: InkWell(
                          onTap: onActionTap,
                          child: SvgPicture.asset(
                            actionIcon,
                            width: 24.w,
                            height: 24.w,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                ]
              : [],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.h),
            child: Container(
              height: 1.h,
              color: AppColors.cardStroke,
            ),
          ),
        );
}
