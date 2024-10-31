import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_app/core/domain/entity/request/login_request_entity.dart';
import 'package:golf_app/core/error/failures.dart';
import 'package:golf_app/features/auth/login/view/forgot_password_page.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../shared/widgets/auth_input_field.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../signup/view/signup_page.dart';
import '../login.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isErrorShown = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void submitLogin() {
    setState(() {
      isErrorShown = false;
      errorMessage = '';
    });
    context.read<LoginBloc>().add(LoginSubmitted(
        loginRequestEntity: LoginRequestEntity(
            email: _emailController.text, password: _passwordController.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            if (state.failure is AuthFailure) {
              setState(() {
                errorMessage = AppLocalizations.of(context)!.error_auth_failure;
                isErrorShown = true;
              });
            }
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Background Image
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 335.h,
                child: Image.asset(
                  Assets.loginBackground,
                  fit: BoxFit.cover,
                ),
              ),

              // Login Form
              Align(
                alignment: Alignment.bottomCenter,
                child: ConstrainedBox(
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
                          Text(
                              AppLocalizations.of(context)!
                                  .text_auth_welcome_back,
                              style: AppTextStyles.title24(context)),

                          SizedBox(height: 24.h),

                          // Email Input Field
                          AuthInputField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: AppLocalizations.of(context)!
                                .text_auth_email_hint,
                            prefixIconAsset: Assets.icLoginUser,
                            suffixIconAsset: Assets.icLoginClear,
                            suffixIconAssetOff: null,
                            canBeObscure: false,
                            isValid: !isErrorShown,
                            onTapSuffixIcon: () => _emailController.clear(),
                            onTextChanged: () => {},
                          ),

                          // Spacing
                          SizedBox(height: 16.h),

                          // Password Input Field
                          AuthInputField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: AppLocalizations.of(context)!
                                .text_auth_password_hint,
                            prefixIconAsset: Assets.icLoginPassword,
                            suffixIconAsset: Assets.icLoginEye,
                            suffixIconAssetOff: Assets.icLoginEyeOff,
                            canBeObscure: true,
                            isValid: !isErrorShown,
                            onTapSuffixIcon: () {},
                            onTextChanged: () => {},
                          ),

                          SizedBox(height: 4.h),

                          // Error Message
                          if (isErrorShown)
                            Row(
                              children: [
                                Text(
                                  errorMessage,
                                  style: AppTextStyles.descriptionRegular12(context)
                                      .copyWith(
                                          color: AppColors.cardDescriptionError),
                                ),
                              ],
                            ),

                          SizedBox(height: 12.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: Material(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordPage()));
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .text_auth_forgot_password,
                                      style: AppTextStyles.descriptionRegular16(
                                              context)
                                          .copyWith(
                                              color:
                                                  AppColors.textButtonActive),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 34.sp),

                          CustomButton(
                            width: double.infinity,
                            height: 64.h,
                            backgroundColor: AppColors.buttonBackgroundPrimary,
                            borderRadius: 12.r,
                            elevation: 0,
                            isLoading: state is LoginLoading,
                            text: AppLocalizations.of(context)!
                                .text_auth_get_started,
                            textStyle: AppTextStyles.title24(context)
                                .copyWith(color: Colors.white),
                            onTap: submitLogin,
                          ),

                          SizedBox(height: 16.h),

                          // Or Sign In With Text
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1.h,
                                  color: AppColors.inputStroke,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                AppLocalizations.of(context)!
                                    .text_auth_or_signin_with,
                                style:
                                    AppTextStyles.descriptionRegular16(context)
                                        .copyWith(
                                            color:
                                                AppColors.cardDescriptionLight),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Container(
                                  height: 1.h,
                                  color: AppColors.inputStroke,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          // Or Sign In With widgets
                          Row(
                            children: [
                              Expanded(
                                  child: SignInWithWidget(
                                asset: Assets.icFacebookLogo,
                                onTap: () {},
                              )),
                              SizedBox(width: 16.w),
                              Expanded(
                                  child: SignInWithWidget(
                                asset: Assets.icGoogleLogo,
                                onTap: () {},
                              )),
                              SizedBox(width: 16.w),
                              Expanded(
                                  child: SignInWithWidget(
                                asset: Assets.icAppleLogo,
                                onTap: () {},
                              )),
                            ],
                          ),

                          SizedBox(height: 16.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .text_auth_do_not_have_account,
                                style:
                                    AppTextStyles.descriptionRegular16(context)
                                        .copyWith(
                                            color:
                                                AppColors.cardDescriptionLight),
                              ),
                              SizedBox(width: 4.w),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4.r),
                                child: Material(
                                  child: InkWell(
                                    onTap: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage())),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .text_auth_signup,
                                      style: AppTextStyles.descriptionRegular16(
                                              context)
                                          .copyWith(
                                              color: AppColors
                                                  .cardDescriptionDark),
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
