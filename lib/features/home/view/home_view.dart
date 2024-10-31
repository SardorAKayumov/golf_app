import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/core/theme/text_styles.dart';

import '../../../core/constants/assets.dart';
import '../home.dart';

class HomeView extends StatefulWidget {
  final VoidCallback onPointRewardClicked;
  const HomeView({super.key, required this.onPointRewardClicked});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 12.h),
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Text(
                    'Home',
                    style: AppTextStyles.title32(context),
                  ),
                ),
                SizedBox(height: 12.h),
                HotNewsWidget(
                  news: [
                    'assets/temp/news_temp_1.png',
                    'assets/temp/news_temp_2.png',
                    'assets/temp/news_temp_3.png',
                    'assets/temp/news_temp_4.png',
                  ],
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    children: [
                      PointReward(
                        showGoToTopupPageIcon: true,
                        onPointRewardClicked: widget.onPointRewardClicked,
                      ),
                      SizedBox(height: 16.h),
                      DiscountField(
                        name: 'The Els Club Desaru Coast',
                        images: [
                          'assets/temp/place_temp_1.png',
                          'assets/temp/place_temp_2.png',
                          'assets/temp/place_temp_3.jpeg',
                          'assets/temp/place_temp_4.png'
                        ],
                        price: 120,
                        isDiscount: true,
                      ),
                      SizedBox(height: 12.h),
                      DiscountField(
                        name: 'Kelab Golf Sarawak',
                        images: [
                          'assets/temp/place_temp_5.jpeg',
                          'assets/temp/place_temp_6.jpeg',
                          'assets/temp/place_temp_7.jpeg',
                        ],
                        price: 150,
                        isDiscount: false,
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
