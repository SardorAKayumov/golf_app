import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import '../booking.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});

  @override
  State<BookingsView> createState() => _BookingsViewState();
}

class _BookingsViewState extends State<BookingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ClipOval(
              child: Material(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    child: SizedBox(
                      width: 32.h,
                      height: 32.h,
                      child: SvgPicture.asset(
                        Assets.icHomeNotification,
                        fit: BoxFit.contain,
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
              AppLocalizations.of(context)!.page_title_bookings,
              style: AppTextStyles.title32(context),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  children: List.generate(
                    2,
                    (index) => Column(
                      children: [
                        if (index != 0) SizedBox(height: 8.h),
                        BookedListItem(
                          name: 'The Els Club Desaru Coast',
                          isExpired: index != 0,
                          playerCount: 2,
                        ),
                      ],
                    ),
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
