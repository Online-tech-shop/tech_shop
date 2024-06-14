import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tech_shop/views/screens/home_screen/views/home_screen.dart';
import 'package:tech_shop/views/screens/home_screen/views/search_screen.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/public_appbar.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_tab_box_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    const SearchScreen(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];
  final List _appBar = [
    PublicAppBar(
        leading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.heart,
              size: 29,
            ),
          ),
        ],
        title: const TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF3F4F8),
            label: Text(
              "Mahsulotlar va turkumlar qidirish",
              style: TextStyle(
                color: Color(0xff8B8B95),
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          ),
        ),
        onTap: () {}),
    PublicAppBar(title: const Text(""), onTap: () {}),
    PublicAppBar(title: const Text("Savat"), onTap: () {}),
    PublicAppBar(title: const Text("Saqlangan"), onTap: () {}),
    PublicAppBar(title: const Text("Profil"), onTap: () {})
  ];

  void onTabBoxPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBar[_currentIndex],
        body: _pages[_currentIndex],
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 15,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTabBoxButton(
                buttonText: 'Bosh sahifa',
                imagePath:
                    'assets/icons/bottom_navigation_bar_icons/home${_currentIndex == 0 ? '' : '_un'}.png',
                currentIndex: 0,
                isSelected: _currentIndex == 0,
                onTabBoxPressed: onTabBoxPressed,
              ),
              CustomTabBoxButton(
                buttonText: 'Katalog',
                imagePath:
                    'assets/icons/bottom_navigation_bar_icons/search${_currentIndex == 1 ? '' : '_un'}.png',
                currentIndex: 1,
                isSelected: _currentIndex == 1,
                onTabBoxPressed: onTabBoxPressed,
              ),
              CustomTabBoxButton(
                buttonText: 'Savat',
                imagePath:
                    'assets/icons/bottom_navigation_bar_icons/cart${_currentIndex == 2 ? '' : '_un'}.png',
                currentIndex: 2,
                isSelected: _currentIndex == 2,
                onTabBoxPressed: onTabBoxPressed,
              ),
              CustomTabBoxButton(
                buttonText: 'Saralangan',
                imagePath:
                    'assets/icons/bottom_navigation_bar_icons/fav${_currentIndex == 3 ? '' : '_un'}.png',
                currentIndex: 3,
                isSelected: _currentIndex == 3,
                onTabBoxPressed: onTabBoxPressed,
              ),
              CustomTabBoxButton(
                buttonText: 'Kabinet',
                imagePath:
                    'assets/icons/bottom_navigation_bar_icons/profile${_currentIndex == 4 ? '' : '_un'}.png',
                currentIndex: 4,
                isSelected: _currentIndex == 4,
                onTabBoxPressed: onTabBoxPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
