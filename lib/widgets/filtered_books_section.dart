import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/blocs/book_bloc.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';
import 'package:flutterschool_bookshop_app/constants/constant_font_size.dart';
import 'package:flutterschool_bookshop_app/constants/dummy_data.dart';
import 'package:flutterschool_bookshop_app/constants/enums.dart';
import 'package:flutterschool_bookshop_app/models/book_model.dart';
import 'package:flutterschool_bookshop_app/pages/book_detail_page.dart';

import '../utils/utils.dart';

class FilteredBooksSection extends StatefulWidget {
  const FilteredBooksSection({super.key});

  @override
  State<FilteredBooksSection> createState() => _FilteredBooksSectionState();
}

class _FilteredBooksSectionState extends State<FilteredBooksSection> {
  late BookBloc bookBloc;

  @override
  void initState() {
    bookBloc = BookBloc(
      books:
          DummyData.booksList.map((item) => BookModel.fromJson(item)).toList(),
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    bookBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<TypeOfBooks?>(
            stream: bookBloc.currentType,
            builder: (context, snapshot) {
              final currentTypeOfBooks = snapshot.data ?? TypeOfBooks.all;
              return Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: TypeOfBooks.values
                          .map(
                            (item) => FilterChip(
                              label: Text(item.value),
                              showCheckmark: false,
                              pressElevation: 0,
                              labelStyle: TextStyle(
                                color: currentTypeOfBooks == item
                                    ? ConstantColor.primaryColor
                                    : ConstantColor.grey,
                                fontSize: ConstantFontSize.headerSize2,
                              ),
                              selectedColor:
                                  ConstantColor.primaryColor.withOpacity(.1),
                              backgroundColor: currentTypeOfBooks == item
                                  ? ConstantColor.primaryColor.withOpacity(.1)
                                  : Theme.of(context).scaffoldBackgroundColor,
                              onSelected: (seletedtypeOfBook) {
                                bookBloc.setTypeOfBook.add(item);
                              },
                              selected: currentTypeOfBooks == item,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              );
            }),
        const SizedBox(height: 10),
        StreamBuilder<Iterable<BookModel>>(
          stream: bookBloc.books,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final books = snapshot.requireData;
              return GridView.count(
                shrinkWrap: true,
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 9 / 18,
                crossAxisCount: 3,
                children: List.generate(
                  books.length,
                  (index) {
                    final aBook = books.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BookDetailPage(bookId: aBook.id),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 156,
                            child: Image.network(
                              aBook.imageUrl,
                              fit: BoxFit.fitWidth,
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
                                  // height: 1,
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
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ],
    );
  }
}
