import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/enums.dart';
import 'package:flutterschool_bookshop_app/models/book_model.dart';

import '../common/custom_cart_badge.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';
import '../utils/utils.dart';
import 'book_detail_page.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage({
    super.key,
    required this.typeOfBooks,
    required this.bookList,
  });

  final TypeOfBooks typeOfBooks;
  final List<BookModel> bookList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ConstantColor.grey,
          ),
        ),
        title: Text(
          typeOfBooks.value,
          style: const TextStyle(
            color: ConstantColor.darkGrey,
            fontSize: ConstantFontSize.headerSizeBig,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: CustomCartBadge(),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.only(top: 10, right: 12, left: 12),
        shrinkWrap: true,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 9 / 20,
        crossAxisCount: 3,
        children: List.generate(
          bookList.length,
          (index) {
            final aBook = bookList.elementAt(index);
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailPage(bookId: aBook.id),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 155,
                    child: Image.network(
                      aBook.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        aBook.category.value,
                        style: const TextStyle(
                          color: ConstantColor.grey,
                          fontSize: ConstantFontSize.headerSize6,
                          // height: 1.2,
                        ),
                      ),
                      Text(
                        aBook.title,
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: ConstantColor.grey,
                          fontSize: ConstantFontSize.headerSize4,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      Text(
                        "${Utils.getCurrency(aBook.price)} LAK",
                        style: const TextStyle(
                          color: ConstantColor.grey,
                          fontSize: ConstantFontSize.headerSize5,
                          // height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
