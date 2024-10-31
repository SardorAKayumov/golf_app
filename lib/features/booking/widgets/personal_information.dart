import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class PersonalInformationWidget extends StatefulWidget {
  const PersonalInformationWidget({
    super.key,
    required this.title,
    required this.isOptional,
  });
  final String title;
  final bool isOptional;

  @override
  State<PersonalInformationWidget> createState() =>
      _PersonalInformationWidgetState();
}

class _PersonalInformationWidgetState extends State<PersonalInformationWidget> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? _selectedGender;

  @override
  void dispose() {
    _fullNameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(13.r),
              ),
              child: CupertinoDatePicker(
                dateOrder: DatePickerDateOrder.mdy,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (date) {
                  setState(() {
                    _dateController.text =
                        DateFormat('dd.MM.yyyy').format(date);
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 436.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyles.title20(context)
                          .copyWith(color: AppColors.cardTitleHighlight),
                    ),
                    if (widget.isOptional)
                      Text(
                        AppLocalizations.of(context)!.text_booking_optional,
                        style: AppTextStyles.desciptionSemiBold16(context)
                            .copyWith(color: AppColors.cardDescriptionLight),
                      ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Full name
                Row(
                  children: [
                    Text(
                      '* ',
                      style: AppTextStyles.desciptionSemiBold12(context)
                          .copyWith(color: AppColors.cardDescriptionError),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_general_full_name,
                      style: AppTextStyles.desciptionSemiBold12(context)
                          .copyWith(color: AppColors.cardTitleDark),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                TextField(
                  controller: _fullNameController,
                  keyboardType: TextInputType.name,
                  style: AppTextStyles.desciptionSemiBold16(context)
                      .copyWith(color: AppColors.inputText),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!
                        .text_booking_full_name_hint,
                    hintStyle: AppTextStyles.descriptionRegular16(context)
                        .copyWith(color: AppColors.inputHint),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.inputStroke),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.inputStroke),
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                // Name should be same as passport warning
                Row(
                  children: [
                    Text(
                      '*',
                      style: AppTextStyles.descriptionRegular12(context)
                          .copyWith(color: AppColors.cardDescriptionWarning),
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .text_booking_name_same_as_passport,
                      style: AppTextStyles.descriptionRegular12(context)
                          .copyWith(color: AppColors.cardDescriptionWarning),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Gender
                Row(
                  children: [
                    Text(
                      '* ',
                      style: AppTextStyles.desciptionSemiBold12(context)
                          .copyWith(color: AppColors.cardDescriptionError),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_general_gender,
                      style: AppTextStyles.desciptionSemiBold12(context)
                          .copyWith(color: AppColors.cardTitleDark),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Theme(
                  data: ThemeData(canvasColor: Colors.white),
                  child: DropdownButtonFormField<String>(
                    value: _selectedGender,
                    style: AppTextStyles.desciptionSemiBold16(context)
                        .copyWith(color: AppColors.inputText),
                    hint: Text(
                      AppLocalizations.of(context)!.text_general_select_gender,
                      style: AppTextStyles.descriptionRegular16(context)
                          .copyWith(color: AppColors.inputHint),
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.inputStroke),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.inputStroke),
                      ),
                    ),
                    items: <String>['Male', 'Female']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedGender = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16.h),
                // Date of birth
                Row(
                  children: [
                    Text(
                      '* ',
                      style: AppTextStyles.desciptionSemiBold12(context)
                          .copyWith(color: AppColors.cardDescriptionError),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_general_date_of_birth,
                      style: AppTextStyles.desciptionSemiBold12(context)
                          .copyWith(color: AppColors.cardTitleDark),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                InkWell(
                  child: TextField(
                    controller: _dateController,
                    onTap: _showDatePicker,
                    autofocus: false,
                    canRequestFocus: false,
                    enableInteractiveSelection: false,
                    keyboardType: TextInputType.name,
                    style: AppTextStyles.desciptionSemiBold16(context)
                        .copyWith(color: AppColors.inputText),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!
                          .text_booking_choose_date_hint,
                      hintStyle: AppTextStyles.descriptionRegular16(context)
                          .copyWith(color: AppColors.inputHint),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      suffixIcon: SvgPicture.asset(
                        Assets.icInputCalendar,
                        width: 24.h,
                        height: 24.h,
                        fit: BoxFit.none,
                        colorFilter: const ColorFilter.mode(
                          AppColors.cardTitleDark,
                          BlendMode.srcIn,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.inputStroke),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.inputStroke),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  height: 1.h,
                  color: AppColors.cardStroke,
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .text_booking_applied_discounts,
                      style: AppTextStyles.desciptionSemiBold16(context)
                          .copyWith(color: AppColors.cardTitleHighlight),
                    ),
                    Container(
                      width: 24.h,
                      height: 24.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cardBackgroundSecondary,
                      ),
                      child: SvgPicture.asset(
                        Assets.icDownArrow,
                        width: 16.w,
                        height: 16.h,
                        fit: BoxFit.none,
                        colorFilter: const ColorFilter.mode(
                          AppColors.inputIconSecondary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Cupertino Date Picker
        ],
      ),
    );
  }
}
