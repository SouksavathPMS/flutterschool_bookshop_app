import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/dummy_data.dart';
import 'package:flutterschool_bookshop_app/pages/recommed_books_page.dart';
import 'package:flutterschool_bookshop_app/widgets/filtered_books_section.dart';

import '../common/custom_title.dart';
import '../constants/constant_colors.dart';
import '../models/book_model.dart';
import '../pages/book_detail_page.dart';
import '../widgets/slide_card_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final recommdedBooks = DummyData.booksList
        .map((item) => BookModel.fromJson(item))
        .toList()
        .where((element) => element.isRecommended);
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecommededBooksPage(
                        bookRecommdedList: recommdedBooks,
                      ),
                    ),
                  );
                },
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
              itemCount: recommdedBooks.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(
                        bookId: recommdedBooks.elementAt(index).id,
                      ),
                    ),
                  );
                },
                child: BookCardItem(
                  index: index,
                  width: width,
                  bookDetail: recommdedBooks.elementAt(index),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const FilteredBooksSection(),
        ],
      ),
    );
  }
}
