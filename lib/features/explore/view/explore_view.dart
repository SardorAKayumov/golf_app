import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/constants/assets.dart';
import 'package:golf_app/core/theme/colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import '../explore.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _showSuffixicon = false;
  String lastSearch = '';

  List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _showSuffixicon = _controller.text.isNotEmpty;
    });
  }

  void _onFocusChanged() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void onSearchSubmitted(String search) {
    setState(() {
      if (search.isEmpty) {
        lastSearch = '';
        return;
      }

      lastSearch = search;
      if (recentSearches.length >= 5) {
        recentSearches.removeLast();
      }
      recentSearches.insert(0, search);
      context
          .read<ExploreBloc>()
          .add(SetRecentSearches(searches: recentSearches));
    });
  }

  void onRecentTap(int index) {
    setState(() {
      _controller.text = recentSearches[index];
      recentSearches.removeAt(index);
      _focusNode.unfocus();
      onSearchSubmitted(_controller.text);
    });
  }

  void onRecentDeleted(int index) {
    setState(() {
      recentSearches.removeAt(index);
      context
          .read<ExploreBloc>()
          .add(SetRecentSearches(searches: recentSearches));
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _isFocused ? false : true,
      onPopInvokedWithResult: (didPop, result) {
        if (_isFocused) {
          _focusNode.unfocus();
        }
      },
      child: Scaffold(
        body: BlocConsumer<ExploreBloc, ExploreState>(
          listener: (context, state) {
            if (state is ExploreRecentSearchesLoaded) {
              recentSearches = state.searches;
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 12.h),

                  // Search Bar
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Container(
                          width: 292.w,
                          decoration: BoxDecoration(
                              color: AppColors.searchBackgroundDark,
                              borderRadius: BorderRadius.circular(12.r)),
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _controller,
                            style: AppTextStyles.descriptionRegular16(context)
                                .copyWith(color: AppColors.cardTitleDark),
                            decoration: InputDecoration(
                              hintText: AppLocalizations.of(context)!
                                  .text_explore_search_hint,
                              hintStyle:
                                  AppTextStyles.descriptionRegular16(context)
                                      .copyWith(
                                          color:
                                              AppColors.searchPlaceholderText),
                              fillColor: AppColors.searchBackgroundDark,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 12.h),
                              prefixIcon: SvgPicture.asset(
                                Assets.icNavbarExplore,
                                width: 24.h,
                                height: 24.h,
                                fit: BoxFit.none,
                              ),
                              suffixIcon: !_showSuffixicon
                                  ? null
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _controller.clear();
                                          _focusNode.requestFocus();
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        Assets.icLoginClear,
                                        width: 16.h,
                                        height: 16.h,
                                        fit: BoxFit.none,
                                      ),
                                    ),
                            ),
                            onSubmitted: (value) => onSearchSubmitted(value),
                          ),
                        ),

                        if (_isFocused) SizedBox(width: 16.w),

                        // Cancel Text Button
                        if (_isFocused)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: Material(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _focusNode.unfocus();
                                    _controller.text = lastSearch;
                                  });
                                },
                                child: SizedBox(
                                  width: 50.w,
                                  height: 20.h,
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .text_explore_search_cancel,
                                      style: AppTextStyles.descriptionBold16(
                                              context)
                                          .copyWith(
                                              color:
                                                  AppColors.textButtonActive),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        // Filter Icon
                        else
                          Row(
                            children: [
                              SizedBox(width: 8.w),
                              Material(
                                child: InkWell(
                                  onTap: () {
                                    // Filter view
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                            const ExploreFilterView(),
                                        transitionDuration: Duration.zero,
                                        reverseTransitionDuration:
                                            Duration.zero,
                                      ),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    Assets.icFilter,
                                    width: 48.w,
                                    height: 48.w,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),

                  // Some dividers if focused
                  if (_isFocused)
                    Column(
                      children: [
                        SizedBox(height: 8.h),
                        Container(
                          width: double.infinity,
                          height: 1.h,
                          color: AppColors.listStroke,
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),

                  // Recent Searches
                  if (_isFocused && _controller.text.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .text_explore_recent,
                                style: AppTextStyles.descriptionBold16(context)
                                    .copyWith(color: AppColors.cardTitleDark),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            height: 317.h,
                            child: ListView(
                              children: List.generate(
                                recentSearches.length,
                                (index) => Column(
                                  children: [
                                    if (index != 0) SizedBox(height: 8.h),
                                    RecentSearchItem(
                                      searchString: recentSearches[index],
                                      onDelete: () => onRecentDeleted(index),
                                      onRecentTap: () => onRecentTap(index),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Discover
                  if (!_isFocused)
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SizedBox(
                          height: 500.h,
                          child: ListView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            children: [
                              SizedBox(height: 16.h),
                              ExploreListItem(
                                image: 'assets/temp/place_temp_1.png',
                                isDiscount: true,
                                name: 'Kelab Golf Sarawak',
                                price: 120,
                              ),
                              SizedBox(height: 12.h),
                              ExploreListItem(
                                image: 'assets/temp/place_temp_2.png',
                                isDiscount: false,
                                name: 'The Els Club Desaru Coast',
                                price: 120,
                              ),
                              SizedBox(height: 12.h),
                              ExploreListItem(
                                image: 'assets/temp/place_temp_1.png',
                                isDiscount: true,
                                name: 'Kelab Golf Sarawak',
                                price: 120,
                              ),
                              SizedBox(height: 12.h),
                              ExploreListItem(
                                image: 'assets/temp/place_temp_4.png',
                                isDiscount: false,
                                name: 'Kelab Golf Sarawak',
                                price: 120,
                              ),
                              SizedBox(height: 12.h),
                              ExploreListItem(
                                image: 'assets/temp/place_temp_3.jpeg',
                                isDiscount: false,
                                name: 'The Els Club Desaru Coast',
                                price: 120,
                              ),
                              SizedBox(height: 12.h),
                              ExploreListItem(
                                image: 'assets/temp/place_temp_1.png',
                                isDiscount: false,
                                name: 'Kelab Golf Sarawak',
                                price: 120,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
