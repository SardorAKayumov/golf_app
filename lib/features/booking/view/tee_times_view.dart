import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:golf_app/core/theme/text_styles.dart';
import 'package:golf_app/features/shared/widgets/custom_button.dart';
import '../booking.dart';

class TeeTimesView extends StatefulWidget {
  const TeeTimesView({super.key});
  final int fromHour = 7;
  final int tillHour = 22;

  @override
  State<TeeTimesView> createState() => _TeeTimesViewState();
}

class _TeeTimesViewState extends State<TeeTimesView>
    with SingleTickerProviderStateMixin {
  late final List<String> shortWeekDays = [
    AppLocalizations.of(context)!.monday_short,
    AppLocalizations.of(context)!.tuesday_short,
    AppLocalizations.of(context)!.wednesday_short,
    AppLocalizations.of(context)!.thursday_short,
    AppLocalizations.of(context)!.friday_short,
    AppLocalizations.of(context)!.saturday_short,
    AppLocalizations.of(context)!.sunday_short,
  ];

  late final List<String> fullMonths = [
    AppLocalizations.of(context)!.january_full,
    AppLocalizations.of(context)!.february_full,
    AppLocalizations.of(context)!.march_full,
    AppLocalizations.of(context)!.april_full,
    AppLocalizations.of(context)!.may_full,
    AppLocalizations.of(context)!.june_full,
    AppLocalizations.of(context)!.july_full,
    AppLocalizations.of(context)!.august_full,
    AppLocalizations.of(context)!.september_full,
    AppLocalizations.of(context)!.october_full,
    AppLocalizations.of(context)!.november_full,
    AppLocalizations.of(context)!.december_full,
  ];

  bool calendarExpanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;
    DateTime selectedDay = DateTime.now(); // Get today's date
    DateTime today = DateTime.now();


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // Calculate the start of the week (Monday) based on today's date
    int daysToMonday = selectedDay.weekday - DateTime.monday;
    DateTime startOfWeek = selectedDay.subtract(Duration(days: daysToMonday));

    return Scaffold(
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
          AppLocalizations.of(context)!.page_title_tee_times,
          style: AppTextStyles.title20(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: Material(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      calendarExpanded = !calendarExpanded;
                      if (calendarExpanded) {
                        _controller.forward();
                      } else {
                        _controller.reverse();
                      }
                    });
                  },
                  child: SizedBox(
                    width: 32.h,
                    height: 32.h,
                    child: SvgPicture.asset(
                      Assets.icCalendar,
                      fit: BoxFit.cover,
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
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 2.h,
            color: AppColors.listStroke,
          ),
          if (!calendarExpanded) ...[
            // Show the week view when not expanded
            Container(
              width: double.infinity,
              height: 121.h,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        shortWeekDays.length,
                        (index) => Text(
                          shortWeekDays[index],
                          style: AppTextStyles.desciptionSemiBold16(context)
                              .copyWith(color: AppColors.calendarInactiveText),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        7,
                        (index) {
                          DateTime currentDay =
                              startOfWeek.add(Duration(days: index));
                          return Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: currentDay.isAtSameMomentAs(selectedDay)
                                  ? AppColors.calendarSelectedBackground
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${currentDay.day}', // Display the day of the month
                                style: AppTextStyles.title20(context).copyWith(
                                  color: currentDay.isAtSameMomentAs(selectedDay)
                                      ? AppColors.calendarSelectedText
                                      : today.month < selectedDay.month || today.day < selectedDay.day || today.weekday < index + 1 ? AppColors.calendarActiveText : AppColors.calendarInactiveText,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 64.w,
                      height: 16.h,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            calendarExpanded = !calendarExpanded;
                            if (calendarExpanded) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                          });
                        },
                        style: ButtonStyle(
                          elevation: const WidgetStatePropertyAll(0),
                          backgroundColor: const WidgetStatePropertyAll(
                              AppColors.buttonBackgroundPrimary),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.r))),
                        ),
                        child: SvgPicture.asset(
                          calendarExpanded
                              ? Assets.icUpArrow
                              : Assets.icDownArrow,
                          width: 12.h,
                          height: 12.h,
                          fit: BoxFit.scaleDown,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            // Show the full calendar when expanded
            Expanded(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: 670.h,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (int monthOffset = 0;
                                  monthOffset < 3;
                                  monthOffset++)
                                _buildMonthCalendar(
                                  DateTime(today.year, today.month + monthOffset),
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                    SizedBox(
                      width: 64.w,
                      height: 16.h,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            calendarExpanded = !calendarExpanded;
                            if (calendarExpanded) {
                              _controller.forward();
                            } else {
                              _controller.reverse();
                            }
                          });
                        },
                        style: ButtonStyle(
                          elevation: const WidgetStatePropertyAll(0),
                          backgroundColor: const WidgetStatePropertyAll(
                              AppColors.buttonBackgroundPrimary),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.r))),
                        ),
                        child: SvgPicture.asset(
                          calendarExpanded
                              ? Assets.icUpArrow
                              : Assets.icDownArrow,
                          width: 12.h,
                          height: 12.h,
                          fit: BoxFit.scaleDown,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    ],
                  );
                },
              ),
            ),
          ],
          // Time slots
          if (!calendarExpanded) ...[
            Container(
              width: double.infinity,
              height: 509.h,
              color: AppColors.cardBackgroundDark,
              child: ListView(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                children: List.generate(
                  widget.tillHour - widget.fromHour + 1,
                  (index) => Column(
                    children: [
                      if (index == 0) SizedBox(height: 8.h),
                      SizedBox(height: 8.h),
                      TeeTimeSlotItem(
                        hour: index + widget.fromHour,
                        isExpandedByDefault: index == 0 ? true : false,
                      ),
                      if (index == widget.tillHour - widget.fromHour)
                        SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 4.h),
              child: CustomButton(
                height: 64.h,
                backgroundColor: AppColors.buttonBackgroundSecondary,
                text: AppLocalizations.of(context)!.text_booking_book_now,
                textStyle: AppTextStyles.title24(context)
                    .copyWith(color: AppColors.buttonTitleDark),
                borderRadius: 12.r,
                width: double.infinity,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookingPage()));
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMonthCalendar(DateTime month) {
    final today = DateTime.now();
    final int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final int firstWeekday = DateTime(month.year, month.month, 1).weekday;
    final List<Widget> dayWidgets = [];

    // Add empty containers for days before the first day of the month
    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(Container(width: 44.w, height: 44.w));
    }

    // Add day widgets for each day in the month
    for (int day = 1; day <= daysInMonth; day++) {
      DateTime currentDay = DateTime(month.year, month.month, day);
      dayWidgets.add(
        ClipOval(
          child: Material(
            child: InkWell(
              onTap: () {
                setState(() {
                  if (currentDay.month < today.month || (currentDay.month == today.month && currentDay.day < today.day)){
                    return;
                  }
                  selectedDay = currentDay;
                });
              },
              child: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color:
                      currentDay.month == selectedDay.month && currentDay.day == selectedDay.day
                          ? AppColors.calendarSelectedBackground
                          : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$day',
                    style: AppTextStyles.title20(context).copyWith(
                      color: currentDay.month == selectedDay.month &&
                              currentDay.day == selectedDay.day
                          ? AppColors.calendarSelectedText
                          : (currentDay.month == today.month && currentDay.day >= today.day) || currentDay.month > today.month
                              ? AppColors.calendarActiveText
                              : AppColors.calendarInactiveText,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        SizedBox(height: 16.h),
        Text(
          '${fullMonths[month.month - 1]} ${month.year}',
          style: AppTextStyles.desciptionSemiBold16(context)
              .copyWith(color: AppColors.cardTitleDark),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              shortWeekDays.length,
              (index) => Text(
                shortWeekDays[index],
                style: AppTextStyles.desciptionSemiBold16(context)
                    .copyWith(color: AppColors.calendarInactiveText),
              ),
            ),
          ),
        ),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: dayWidgets,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
