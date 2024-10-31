import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golf_app/core/theme/colors.dart';
import 'package:golf_app/core/theme/text_styles.dart';
import 'package:golf_app/features/shared/widgets/custom_appbar.dart';
import 'package:golf_app/features/shared/widgets/custom_button.dart';
import 'package:golf_app/features/topup/topup.dart';
import 'package:golf_app/injection_handler.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cardNumberController.addListener(_onCardNumberTextChanged);
    _expiryDateController.addListener(_onExpiryDateTextChanged);
  }

  @override
  void dispose() {
    _cardNumberController.removeListener(_onCardNumberTextChanged);
    _expiryDateController.removeListener(_onExpiryDateTextChanged);
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  void _onCardNumberTextChanged() {
    String text = _cardNumberController.text
        .replaceAll(' ', ''); // Remove existing spaces
    StringBuffer formattedText = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formattedText.write(' '); // Add a space after every 4 characters
      }
      formattedText.write(text[i]);
    }

    // Update the text field with the formatted text
    if (formattedText.toString() != _cardNumberController.text) {
      // Only update if the text has changed
      _cardNumberController.value = TextEditingValue(
        text: formattedText.toString(),
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  void _onExpiryDateTextChanged() {
    String text = _expiryDateController.text
        .replaceAll(RegExp(r'[^0-9]'), ''); // Remove non-digit characters

    // // Ensure the first character is 0 or 1
    // if (text.isNotEmpty) {
    //   if (text[0] == '1' &&
    //       text.length == 2 &&
    //       (text[1] != '0' && text[1] != '1' && text[1] != '2')) {
    //     text = '1'; // Limit second character to 0-2 if first is 1
    //   } else if (text[0] == '0' && text.length == 2 && text[1] != '0') {
    //     // Allow any digit for the second character if first is 0
    //   } else if (text[0] != '0' && text[0] != '1') {
    //     text = ''; // Reset if first character is not 0 or 1
    //   }
    // }

    // Format the text to MM/YY
    StringBuffer formattedText = StringBuffer();
    if (text.length > 2) {
      formattedText.write(text.substring(0, 2)); // MM
      formattedText.write('/'); // Add the slash
      formattedText.write(text.substring(2, text.length)); // YY
    } else {
      formattedText.write(text); // Just MM or empty
    }

    // Update the text field with the formatted text
    if (formattedText.toString() != _expiryDateController.text) {
      _expiryDateController.value = TextEditingValue(
        text: formattedText.toString(),
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<TopupBloc>(),
      child: Scaffold(
        appBar: CustomAppBar(
          context: context,
          title: AppLocalizations.of(context)!.page_title_card_details,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 21.h),
                  Row(
                    children: [
                      Text(
                        '* ',
                        style: AppTextStyles.desciptionSemiBold12(context)
                            .copyWith(color: AppColors.cardDescriptionError),
                      ),
                      Text(
                        AppLocalizations.of(context)!.text_topup_card_number,
                        style: AppTextStyles.desciptionSemiBold12(context)
                            .copyWith(color: AppColors.cardTitleDark),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: double.infinity,
                    height: 64.h,
                    child: TextField(
                      controller: _cardNumberController,
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.number,
                      style: AppTextStyles.desciptionSemiBold16(context)
                          .copyWith(color: AppColors.cardTitleDark),
                      inputFormatters: [LengthLimitingTextInputFormatter(19)],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: SizedBox(
                            width: 36.h,
                            height: 36.h,
                            child: Image.asset(
                              'assets/temp/visa_small.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.inputStroke),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.inputStroke),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '* ',
                                style:
                                    AppTextStyles.desciptionSemiBold12(context)
                                        .copyWith(
                                            color:
                                                AppColors.cardDescriptionError),
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .text_topup_expiry_date,
                                style:
                                    AppTextStyles.desciptionSemiBold12(context)
                                        .copyWith(
                                            color: AppColors.cardTitleDark),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 87.w,
                            height: 64.h,
                            child: TextField(
                              controller: _expiryDateController,
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.number,
                              style: AppTextStyles.desciptionSemiBold16(context)
                                  .copyWith(color: AppColors.cardTitleDark),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(5)
                              ],
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.w),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.inputStroke),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.inputStroke),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '* ',
                                style:
                                    AppTextStyles.desciptionSemiBold12(context)
                                        .copyWith(
                                            color:
                                                AppColors.cardDescriptionError),
                              ),
                              Text(
                                'CVV',
                                style:
                                    AppTextStyles.desciptionSemiBold12(context)
                                        .copyWith(
                                            color: AppColors.cardTitleDark),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 87.w,
                            height: 64.h,
                            child: TextField(
                              controller: _cvvController,
                              maxLines: null,
                              expands: true,
                              keyboardType: TextInputType.number,
                              style: AppTextStyles.desciptionSemiBold16(context)
                                  .copyWith(color: AppColors.cardTitleDark),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(3)
                              ],
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16.w),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.inputStroke),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.inputStroke),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Text(
                        '* ',
                        style: AppTextStyles.desciptionSemiBold12(context)
                            .copyWith(color: AppColors.cardDescriptionError),
                      ),
                      Text(
                        AppLocalizations.of(context)!.text_topup_card_holder,
                        style: AppTextStyles.desciptionSemiBold12(context)
                            .copyWith(color: AppColors.cardTitleDark),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    width: double.infinity,
                    height: 64.h,
                    child: TextField(
                      controller: _cardHolderController,
                      maxLines: null,
                      expands: true,
                      keyboardType: TextInputType.name,
                      style: AppTextStyles.desciptionSemiBold16(context)
                          .copyWith(color: AppColors.cardTitleDark),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z ]')) // Allow only letters
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.inputStroke),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.inputStroke),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h),
              child: CustomButton(
                width: double.infinity,
                height: 64.h,
                backgroundColor: AppColors.buttonBackgroundPrimary,
                text: AppLocalizations.of(context)!.text_topup_add_card,
                textStyle: AppTextStyles.title24(context)
                    .copyWith(color: Colors.white),
                borderRadius: 8.r,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
