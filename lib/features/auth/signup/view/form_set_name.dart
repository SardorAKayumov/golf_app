import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/widgets/custom_button.dart';

class SetNameForm extends StatefulWidget {
  const SetNameForm({super.key});

  @override
  State<SetNameForm> createState() => _SetNameFormState();
}

class _SetNameFormState extends State<SetNameForm> {
  final _nameController = TextEditingController();
  bool isRealName = false;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 487.h),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  SizedBox(height: 24.h),
                  Text(
                      AppLocalizations.of(context)!.text_auth_what_is_your_name,
                      style: AppTextStyles.title24(context)),

                  SizedBox(height: 24.h),

                  // Name Input Field
                  TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
                    ],
                    style: AppTextStyles.descriptionRegular16(context)
                        .copyWith(color: AppColors.inputText),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!
                          .text_auth_hint_input_your_name,
                      hintStyle: AppTextStyles.descriptionRegular16(context)
                          .copyWith(color: AppColors.inputHint),
                      filled: true,
                      fillColor: Colors.white,
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
                  ),

                  SizedBox(height: 16.sp),

                  CheckboxListTile(
                    value: isRealName,
                    onChanged: (value) {
                      setState(() {
                        isRealName = value ?? false;
                      });
                    },
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.r)),
                    side: const BorderSide(color: AppColors.buttonStroke),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      AppLocalizations.of(context)!
                          .text_auth_name_is_correct_confirmation,
                      style: AppTextStyles.descriptionRegular12(context)
                          .copyWith(color: AppColors.cardDescriptionWarning),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
              Column(
                children: [
                  CustomButton(
                    width: double.infinity,
                    height: 64.h,
                    backgroundColor: AppColors.buttonBackgroundPrimary,
                    borderRadius: 12.r,
                    elevation: 0,
                    isLoading: false,
                    text:
                        AppLocalizations.of(context)!.text_auth_create_account,
                    textStyle: AppTextStyles.title24(context)
                        .copyWith(color: Colors.white),
                    onTap: () {},
                  ),
                  SizedBox(height: 93.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
