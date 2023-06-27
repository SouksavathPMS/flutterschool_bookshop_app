import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/dummy_data.dart';
import 'package:flutterschool_bookshop_app/pages/recommed_books_page.dart';
import 'package:flutterschool_bookshop_app/widgets/filtered_books_section.dart';
import 'package:provider/provider.dart';

import '../blocs/search_bloc.dart';
import '../common/custom_title.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';
import '../models/book_model.dart';
import '../notifier/page_notifier.dart';
import '../pages/book_detail_page.dart';
import '../utils/utils.dart';
import '../widgets/slide_card_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    super.dispose();
    _searchBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final recommdedBooks = DummyData.booksList
        .map((item) => BookModel.fromJson(item))
        .toList()
        .where((element) => element.isRecommended);
    return StreamBuilder<Iterable<BookModel>?>(
        stream: context.read<PageNotifier>().searchBloc.searchBooks,
        builder: (context, snapshot) {
          final searchedBook = snapshot.data;
          return searchedBook == null
              ? SingleChildScrollView(
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
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
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
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 4, right: 12, left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ຜົນການຄົ້ນຫາ '${searchedBook.length}'",
                        style: const TextStyle(
                          color: ConstantColor.grey,
                          fontSize: ConstantFontSize.headerSize2,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 9 / 18,
                          crossAxisCount: 3,
                          children: List.generate(
                            searchedBook.length,
                            (index) {
                              final aBook = searchedBook.elementAt(index);
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          aBook.category.value,
                                          style: const TextStyle(
                                            color: ConstantColor.grey,
                                            fontSize:
                                                ConstantFontSize.headerSize6,
                                            // height: 1,
                                          ),
                                        ),
                                        Text(
                                          aBook.title,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: ConstantColor.grey,
                                            fontSize:
                                                ConstantFontSize.headerSize4,
                                            fontWeight: FontWeight.bold,
                                            height: 1.1,
                                          ),
                                        ),
                                        Text(
                                          "${Utils.getCurrency(aBook.price)} LAK",
                                          style: const TextStyle(
                                            color: ConstantColor.grey,
                                            fontSize:
                                                ConstantFontSize.headerSize5,
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
                      ),
                    ],
                  ),
                );
        });
  }
}
