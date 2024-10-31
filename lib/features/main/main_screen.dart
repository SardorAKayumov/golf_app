import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:golf_app/features/booking/booking.dart';
import 'package:golf_app/features/explore/view/explore_page.dart';
import 'package:golf_app/features/topup/topup.dart';

import '../../core/constants/assets.dart';
import '../../core/theme/colors.dart';
import '../home/view/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  late final List<Widget> pages = [
    HomePage(onRewardPointClicked: _navigateToTopupPage),
    const ExplorePage(),
    const BookingsPage(),
    const TopupPage(),
    Scaffold(),
  ];

  final icons = [
    Assets.icNavbarHome,
    Assets.icNavbarExplore,
    Assets.icNavbarBookings,
    Assets.icNavbarWallet,
    Assets.icNavbarProfile,
  ];

  final titles = [
    'Home',
    'Explore',
    'Bookings',
    'Topup',
    'Profile',
  ];

  void _navigateToTopupPage() {
    setState(() {
      _selectedIndex = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.iconActive,
        unselectedItemColor: AppColors.iconInactive,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: List.generate(
            pages.length,
            (index) => _bottomNavigationBarItem(
                icons[index], titles[index], index)),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(
      String icon, String title, int index) {
    return BottomNavigationBarItem(
      activeIcon: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: SvgPicture.asset(icon, width: 32.w, height: 32.h, color: AppColors.iconActive),
      ),
      icon: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: SvgPicture.asset(icon, width: 32.w, height: 32.h, color: AppColors.iconInactive),
      ),
      label: title,
    );
  }
}
