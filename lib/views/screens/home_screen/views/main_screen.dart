import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:tech_shop/viewmodels/sql_view_model.dart';
import 'package:tech_shop/views/screens/favourite_screen/screens/favourite_screen.dart';
import 'package:tech_shop/views/screens/home_screen/views/home_screen.dart';
import 'package:tech_shop/views/screens/catalog_screen/screens/catalog_screen.dart';
import 'package:tech_shop/views/screens/home_screen/widgets/custom_tab_box_button.dart';
import 'package:tech_shop/views/screens/profile/profile_screen.dart';
import 'package:tech_shop/views/screens/save_screen/views/save_screen.dart';

class MainScreen extends StatefulWidget {
  final int n;

  const MainScreen({Key? key, this.n = 0}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  final List<Widget> _pages = [
    HomeScreen(),
    const CatalogScreen(),
    const SaveScreen(),
    const FavouriteScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.n;
  }

  void onTabBoxPressed(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int cartNum = Provider.of<SaveViewModel>(context).saves.length;

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTabBoxButton(
                    buttonText: 'bosh_sahifa'.tr(),
                    imagePath:
                        'assets/icons/bottom_navigation_bar_icons/home${_currentIndex == 0 ? '' : '_un'}.png',
                    currentIndex: 0,
                    isSelected: _currentIndex == 0,
                    onTabBoxPressed: onTabBoxPressed,
                  ),
                  CustomTabBoxButton(
                    buttonText: 'katalog'.tr(),
                    imagePath:
                        'assets/icons/bottom_navigation_bar_icons/search${_currentIndex == 1 ? '' : '_un'}.png',
                    currentIndex: 1,
                    isSelected: _currentIndex == 1,
                    onTabBoxPressed: onTabBoxPressed,
                  ),
                  CustomTabBoxButton(
                    buttonText: 'savat'.tr(),
                    imagePath:
                        'assets/icons/bottom_navigation_bar_icons/cart${_currentIndex == 2 ? '' : '_un'}.png',
                    currentIndex: 2,
                    isSelected: _currentIndex == 2,
                    onTabBoxPressed: onTabBoxPressed,
                  ),
                  CustomTabBoxButton(
                    buttonText: 'saralangan'.tr(),
                    imagePath:
                        'assets/icons/bottom_navigation_bar_icons/fav${_currentIndex == 3 ? '' : '_un'}.png',
                    currentIndex: 3,
                    isSelected: _currentIndex == 3,
                    onTabBoxPressed: onTabBoxPressed,
                  ),
                  CustomTabBoxButton(
                    buttonText: 'kabinet'.tr(),
                    imagePath:
                        'assets/icons/bottom_navigation_bar_icons/profile${_currentIndex == 4 ? '' : '_un'}.png',
                    currentIndex: 4,
                    isSelected: _currentIndex == 4,
                    onTabBoxPressed: onTabBoxPressed,
                  ),
                ],
              ),
            ),
            cartNum == 0
                ? const Text("").tr()
                : Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width / 2 - 10,
                    child: Container(
                      height: 30,
                      width: 16,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          cartNum.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
