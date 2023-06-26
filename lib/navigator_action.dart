import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/common/get_appbar.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';
import 'package:flutterschool_bookshop_app/constants/constant_font_size.dart';
import 'package:flutterschool_bookshop_app/screens/category_screen.dart';
import 'package:flutterschool_bookshop_app/screens/favorite_screen.dart';
import 'package:flutterschool_bookshop_app/screens/home_screen.dart';
import 'package:flutterschool_bookshop_app/screens/user_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NaviagtorAction extends StatefulWidget {
  const NaviagtorAction({super.key});

  @override
  State<NaviagtorAction> createState() => _NaviagtorActionState();
}

class _NaviagtorActionState extends State<NaviagtorAction> {
  int _currentIndex = 0;

  final List<Widget> _currentScreen = [
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GetAppBar.instance.getAppbar(currentPage: _currentIndex),
      body: IndexedStack(
        index: _currentIndex,
        children: _currentScreen,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SalomonBottomBar(
          itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.home_outlined,
                size: 28,
              ),
              title: const Text(
                "ໜ້າຫຼັກ",
                style: TextStyle(
                  fontFamily: "NotoSansLao",
                  fontSize: ConstantFontSize.headerSize2,
                  height: 1.3,
                ),
              ),
              selectedColor: ConstantColor.primaryColor,
              activeIcon: const Icon(
                Icons.home,
                size: 28,
              ),
            ),

            SalomonBottomBarItem(
              icon: const Icon(
                Icons.category_outlined,
                size: 28,
              ),
              title: const Text(
                "ໝວດໝູ່",
                style: TextStyle(
                  height: 1.3,
                  fontFamily: "NotoSansLao",
                  fontSize: ConstantFontSize.headerSize2,
                ),
              ),
              selectedColor: ConstantColor.primaryColor,
              activeIcon: const Icon(
                Icons.category,
                size: 28,
              ),
            ),

            SalomonBottomBarItem(
              icon: const Icon(
                Icons.favorite_border,
                size: 28,
              ),
              title: const Text(
                "ທີ່ທ່ານມັກ",
                style: TextStyle(
                  height: 1.3,
                  fontFamily: "NotoSansLao",
                  fontSize: ConstantFontSize.headerSize2,
                ),
              ),
              selectedColor: ConstantColor.primaryColor,
              activeIcon: const Icon(
                Icons.favorite,
                size: 28,
              ),
            ),

            SalomonBottomBarItem(
              icon: const Icon(
                Icons.person_outline,
                size: 28,
              ),
              title: const Text(
                "ຜູ້ໃຊ້ງານ",
                style: TextStyle(
                  height: 1.3,
                  fontFamily: "NotoSansLao",
                  fontSize: ConstantFontSize.headerSize2,
                ),
              ),
              selectedColor: ConstantColor.primaryColor,
              activeIcon: const Icon(
                Icons.person,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
