import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotNewsWidget extends StatefulWidget {
  final List<String> news;
  const HotNewsWidget({super.key, required this.news});

  @override
  State<HotNewsWidget> createState() => _HotNewsWidgetState();
}

class _HotNewsWidgetState extends State<HotNewsWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _currentIndex = _pageController.page!.round() % widget.news.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 154.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Image.asset(
                    widget.news[index % widget.news.length],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          if (widget.news.isNotEmpty && widget.news.length > 1)
            Positioned(
              bottom: 16.w,
              child: Row(
                children: List.generate(
                  widget.news.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Container(
                      width: 8.w,
                      height: 8.w,
                      decoration: BoxDecoration(
                        color: index == _currentIndex
                            ? Colors.white
                            : const Color(0x4DFFFFFF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}