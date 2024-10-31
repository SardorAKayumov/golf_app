import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/widgets/custom_button.dart';

class VerificationForm extends StatefulWidget {
  const VerificationForm({super.key});

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  final List<TextEditingController> _inputControllers =
      List.generate(4, (_) => TextEditingController());
  String email = 'john@gmail.com';
  bool isErrorShown = false;

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
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 24.h),
              Text(AppLocalizations.of(context)!.text_auth_verification,
                  style: AppTextStyles.title24(context)),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.text_auth_code_sent_to,
                    style: AppTextStyles.descriptionRegular16(context)
                        .copyWith(color: AppColors.cardDescriptionLight),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    email,
                    style: AppTextStyles.descriptionRegular16(context)
                        .copyWith(color: AppColors.cardDescriptionDark),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Code Input
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) {
                    return Container(
                      width: 64.w,
                      height: 64.w,
                      decoration: BoxDecoration(
                        color: isErrorShown ? AppColors.inputBackgroundError : Colors.white,
                        border: Border.all(color: isErrorShown ? AppColors.inputErrorStroke : AppColors.inputStroke),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Center(
                        child: TextField(
                          controller: _inputControllers[index],
                          textAlign: TextAlign.center,
                          style: AppTextStyles.title32(context)
                              .copyWith(color: Colors.black),
                          cursorHeight: 24.h,
                          maxLength: 1, // Limit to 1 character
                          decoration: null,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.length == 1 && index < 3) {
                              FocusScope.of(context)
                                  .nextFocus(); // Move to the next input
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context)
                                  .previousFocus(); // Move to the previous input
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 4.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.w),
                child: Row(
                  children: [
                    Text(
                      isErrorShown
                          ? '*${AppLocalizations.of(context)!.text_auth_verification_code_incorrect}'
                          : '',
                      style: AppTextStyles.descriptionRegular12(context)
                          .copyWith(color: AppColors.cardDescriptionError),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 136.h),
              CustomButton(
                width: double.infinity,
                height: 64.h,
                backgroundColor: AppColors.buttonBackgroundPrimary,
                borderRadius: 12.r,
                elevation: 0,
                isLoading: false,
                text:
                    AppLocalizations.of(context)!.text_auth_button_verify_email,
                textStyle: AppTextStyles.title24(context)
                    .copyWith(color: Colors.white),
                onTap: () {setState(() {
                      isErrorShown = !isErrorShown;
                    });},
              ),
              SizedBox(height: 19.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!
                        .text_auth_already_have_account,
                    style: AppTextStyles.descriptionRegular16(context)
                        .copyWith(color: AppColors.cardDescriptionLight),
                  ),
                  SizedBox(width: 4.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: Material(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          AppLocalizations.of(context)!
                              .text_auth_verification_resend,
                          style: AppTextStyles.descriptionRegular16(context)
                              .copyWith(color: AppColors.cardDescriptionDark),
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
    );
  }
}
