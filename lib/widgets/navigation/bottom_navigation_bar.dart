import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:style_sphere/constants/app_colors.dart';
import 'package:style_sphere/screens/about.dart';
import 'package:style_sphere/screens/blog_page.dart';
import 'package:style_sphere/screens/home_page.dart';
import 'package:style_sphere/screens/products_page.dart';

BottomNavigationBarItem buildNavItem({required String iconPath}) {
  return BottomNavigationBarItem(
    icon: SvgPicture.asset(iconPath, height: 22, color: Colors.grey),
    label: '',
    activeIcon: Column(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(iconPath, height: 22, color: Colors.black),
        Transform.rotate(
          angle: 45 * 3.1415927 / 180,
          child: Container(width: 6, height: 6, color: AppColors.secondary),
        ),
      ],
    ),
  );
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ProductsPage(),
    const BlogPage(),
    const AboutScreen(),
  ];

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    setState(() {
      _selectedIndex = index;
    });
  }

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color(0xFFEEEEEE),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          buildNavItem(iconPath: 'assets/icons/home.svg'),
          buildNavItem(iconPath: 'assets/icons/search.svg'),
          buildNavItem(iconPath: 'assets/icons/bell.svg'),
          buildNavItem(iconPath: 'assets/icons/user.svg'),
        ],
      ),
    );
  }
}
