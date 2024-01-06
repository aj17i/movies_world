import 'package:flutter/material.dart';
import 'carousel_card.dart';

class HorizontalCarousel extends StatefulWidget {
  @override
  _HorizontalCarouselState createState() => _HorizontalCarouselState();
}

class _HorizontalCarouselState extends State<HorizontalCarousel> {
  final PageController _pageController = PageController(
    viewportFraction: 0.6,
  );

  @override
  void initState() {
    super.initState();
    _autoScroll();
  }

  void _autoScroll() {
    Future.delayed(const Duration(seconds: 2), () {
      _pageController.nextPage(
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
      _autoScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.0,
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return CarouselCard(index: index);
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _checkPage() {
    if (_pageController.page == 10 - 1.0) {
      _pageController.jumpToPage(0);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pageController.addListener(_checkPage);
  }
}