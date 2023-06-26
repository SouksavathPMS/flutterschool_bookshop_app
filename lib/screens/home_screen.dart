import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/widgets/filtered_books_section.dart';

import '../common/custom_title.dart';
import '../constants/constant_colors.dart';
import '../widgets/slide_card_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 12, left: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTitle(title: "ປື້ມແນະນຳ"),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "ທັງໝົດ",
                  style: TextStyle(
                    color: ConstantColor.grey.withOpacity(.3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 153,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) => BookCardItem(width: width),
            ),
          ),
          const SizedBox(height: 12),
          const FilteredBooksSection(),
        ],
      ),
    );
  }
}
