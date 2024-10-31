import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/widgets/auth_input_field.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../login/view/login_page.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  bool isEmailErrorShown = false;
  bool isPasswordErrorShown = false;
  String errorEmailMessage = '';
  String errorPasswordMessage = '';

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 563.h),
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
              Text(AppLocalizations.of(context)!.text_auth_signup,
                  style: AppTextStyles.title24(context)),
        
              SizedBox(height: 24.h),
        
              // ID Input Field
              AuthInputField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                hintText: AppLocalizations.of(context)!.text_auth_email_hint,
                prefixIconAsset: Assets.icLoginUser,
                suffixIconAsset: Assets.icLoginClear,
                suffixIconAssetOff: null,
                canBeObscure: false,
                isValid: !isEmailErrorShown,
                onTapSuffixIcon: () => _emailController.clear(),
                onTextChanged: () => {},
              ),
        
              if (isEmailErrorShown) SizedBox(height: 4.h),
        
              if (isEmailErrorShown)
                Text(
                  errorEmailMessage,
                  style: AppTextStyles.descriptionRegular12(context)
                      .copyWith(color: AppColors.cardDescriptionError),
                ),
        
              // Spacing
              SizedBox(height: 16.h),
        
              // Password Input Field
              AuthInputField(
                controller: _passwordController,
                keyboardType: TextInputType.number,
                hintText: AppLocalizations.of(context)!.text_auth_password_hint,
                prefixIconAsset: Assets.icLoginPassword,
                suffixIconAsset: Assets.icLoginEye,
                suffixIconAssetOff: Assets.icLoginEyeOff,
                canBeObscure: true,
                isValid: !isPasswordErrorShown,
                onTapSuffixIcon: () {},
                onTextChanged: () => {},
              ),
        
              SizedBox(height: 16.h),
        
              AuthInputField(
                controller: _passwordConfirmationController,
                keyboardType: TextInputType.number,
                hintText: AppLocalizations.of(context)!.text_auth_password_hint,
                prefixIconAsset: Assets.icLoginPassword,
                suffixIconAsset: Assets.icLoginEye,
                suffixIconAssetOff: Assets.icLoginEyeOff,
                canBeObscure: true,
                isValid: !isPasswordErrorShown,
                onTapSuffixIcon: () {},
                onTextChanged: () => {},
              ),
        
              SizedBox(height: 4.h),
        
              // Error Message
              if (isPasswordErrorShown)
                Text(
                  errorPasswordMessage,
                  style: AppTextStyles.descriptionRegular12(context)
                      .copyWith(color: AppColors.cardDescriptionError),
                ),
        
              SizedBox(height: 84.sp),
        
              CustomButton(
                width: double.infinity,
                height: 64.h,
                backgroundColor: AppColors.buttonBackgroundPrimary,
                borderRadius: 12.r,
                elevation: 0,
                isLoading: false,
                text: AppLocalizations.of(context)!.text_auth_create_account,
                textStyle:
                    AppTextStyles.title24(context).copyWith(color: Colors.white),
                onTap: () {},
              ),
        
              SizedBox(height: 19.h),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.text_auth_already_have_account,
                    style: AppTextStyles.descriptionRegular16(context)
                        .copyWith(color: AppColors.cardDescriptionLight),
                  ),
                  SizedBox(width: 4.w),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: Material(
                      child: InkWell(
                        onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage())),
                        child: Text(
                          AppLocalizations.of(context)!.text_auth_login,
                          style: AppTextStyles.descriptionRegular16(context)
                              .copyWith(color: AppColors.textButtonActive),
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
