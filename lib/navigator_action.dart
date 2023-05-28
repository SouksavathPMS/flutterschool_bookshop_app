import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';
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
      body: _currentScreen.elementAt(_currentIndex),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SalomonBottomBar(
          itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home_outlined),
              title: const Text(
                "ໜ້າຫຼັກ",
                style: TextStyle(
                  fontFamily: "NotoSansLao",
                ),
              ),
              selectedColor: ConstantColor.primaryColor,
              activeIcon: const Icon(Icons.home),
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.category_outlined),
              title: const Text(
                "ໝວດໝູ່",
                style: TextStyle(
                  fontFamily: "NotoSansLao",
                ),
              ),
              selectedColor: ConstantColor.primaryColor,
              activeIcon: const Icon(Icons.category),
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.favorite_border),
              title: const Text(
                "ທີ່ທ່ານມັກ",
                style: TextStyle(
                  fontFamily: "NotoSansLao",
                ),
              ),
              selectedColor: ConstantColor.primaryColor,
              activeIcon: const Icon(Icons.favorite),
            ),

            SalomonBottomBarItem(
              icon: const Icon(Icons.person_outline),
              title: const Text(
                "ຜູ້ໃຊ້ງານ",
                style: TextStyle(
                  fontFamily: "NotoSansLao",
                ),
              ),
              selectedColor: ConstantColor.primaryColor,
              activeIcon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
