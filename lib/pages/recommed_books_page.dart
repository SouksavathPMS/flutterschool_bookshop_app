import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';

import '../common/custom_cart_badge.dart';
import '../constants/constant_font_size.dart';
import '../models/book_model.dart';
import '../widgets/slide_card_item.dart';
import 'book_detail_page.dart';

class RecommededBooksPage extends StatefulWidget {
  const RecommededBooksPage({
    super.key,
    required this.bookRecommdedList,
  });

  final Iterable<BookModel> bookRecommdedList;

  @override
  State<RecommededBooksPage> createState() => _RecommededBooksPageState();
}

class _RecommededBooksPageState extends State<RecommededBooksPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ConstantColor.darkGrey,
          ),
        ),
        title: const Text(
          "ປື້ມແນະນຳ",
          style: TextStyle(
            color: ConstantColor.darkGrey,
            fontSize: ConstantFontSize.headerSizeBig,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: CustomCartBadge(),
          )
        ],
      ),
      body: ListView.separated(
        padding:
            const EdgeInsets.only(top: 10, right: 12, left: 12, bottom: 80),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(
                    bookId: widget.bookRecommdedList.elementAt(index).id,
                  ),
                ),
              );
            },
            child: SizedBox(
              height: 170,
              child: BookCardItem(
                index: index,
                width: width * .96,
                bookDetail: widget.bookRecommdedList.elementAt(index),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: widget.bookRecommdedList.length,
      ),
    );
  }
}
