import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/pages/cart_page.dart';

import '../constants/constant_colors.dart';

class CustomCartBadge extends StatelessWidget {
  const CustomCartBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CartPage(),
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: badges.Badge(
          badgeAnimation: badges.BadgeAnimation.scale(),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: ConstantColor.darkGrey,
          ),
        ),
      ),
    );
  }
}
