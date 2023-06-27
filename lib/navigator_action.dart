import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/common/get_appbar.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';
import 'package:flutterschool_bookshop_app/constants/constant_font_size.dart';
import 'package:flutterschool_bookshop_app/notifier/page_notifier.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'blocs/search_bloc.dart';
import 'constants/dummy_data.dart';
import 'models/book_model.dart';

class NaviagtorAction extends StatefulWidget {
  const NaviagtorAction({super.key});

  @override
  State<NaviagtorAction> createState() => _NaviagtorActionState();
}

class _NaviagtorActionState extends State<NaviagtorAction> {
  late final SearchBloc _searchBloc;
  @override
  void initState() {
    super.initState();
    _searchBloc = SearchBloc(
        books: DummyData.booksList
            .map((item) => BookModel.fromJson(item))
            .toList());
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageProvider = context.watch<PageNotifier>();
    return Scaffold(
      appBar:
          GetAppBar.instance.getAppbar(currentPage: pageProvider.currentIndex),
      body: pageProvider.currentScreen[pageProvider.currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SalomonBottomBar(
          itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          currentIndex: pageProvider.currentIndex,
          onTap: (i) => context.read<PageNotifier>().changePage(i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.home_outlined,
                size: 30,
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
                size: 30,
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
