// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterschool_bookshop_app/constants/enums.dart';

import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.imagePath,
    required this.typeOfBooks,
    required this.onPressed,
    required this.amount,
  }) : super(key: key);

  final String imagePath;
  final TypeOfBooks typeOfBooks;
  final Function onPressed;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Column(
        children: [
          Container(
            width: 83,
            height: 76,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: ConstantColor.primaryColor.withOpacity(.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              imagePath,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            typeOfBooks.value,
            style: const TextStyle(
              color: ConstantColor.grey,
              fontSize: ConstantFontSize.headerSize,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          Text(
            "$amount ຫົວ",
            style: TextStyle(
              color: ConstantColor.grey.withOpacity(.6),
              fontSize: ConstantFontSize.headerSize6,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
