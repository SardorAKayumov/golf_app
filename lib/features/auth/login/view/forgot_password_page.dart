import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:golf_app/core/theme/text_styles.dart';
import 'package:golf_app/features/shared/widgets/auth_input_field.dart';
import 'package:golf_app/features/shared/widgets/custom_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool isErrorShown = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 1.h,
              color: AppColors.cardStroke,
            ),
            SizedBox(height: 24.h),
            Text(
              AppLocalizations.of(context)!.page_title_forgot_password,
              style: AppTextStyles.title24(context),
            ),
            SizedBox(
              width: 342.w,
              child: Text(
                AppLocalizations.of(context)!
                    .text_auth_enter_email_to_reset_password,
                style: AppTextStyles.descriptionRegular12(context)
                    .copyWith(color: AppColors.cardDescriptionLight),
              ),
            ),
            SizedBox(height: 12.h),

            // ID Input Field
            AuthInputField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hintText: AppLocalizations.of(context)!.text_auth_email_hint,
              prefixIconAsset: Assets.icLoginUser,
              suffixIconAsset: Assets.icLoginClear,
              suffixIconAssetOff: null,
              canBeObscure: false,
              isValid: !isErrorShown,
              onTapSuffixIcon: () => _emailController.clear(),
              onTextChanged: () => {},
            ),

            SizedBox(height: 410.h),

            CustomButton(
              height: 64.h,
              backgroundColor: AppColors.buttonBackgroundPrimary,
              text: AppLocalizations.of(context)!.text_auth_button_receive_code,
              textStyle:
                  AppTextStyles.title24(context).copyWith(color: Colors.white),
              borderRadius: 8.r,
              width: double.infinity,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
