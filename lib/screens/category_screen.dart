import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/dummy_data.dart';
import 'package:flutterschool_bookshop_app/constants/enums.dart';
import 'package:flutterschool_bookshop_app/models/book_model.dart';
import 'package:flutterschool_bookshop_app/pages/category_detail_page.dart';

import '../widgets/category_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.only(top: 10, right: 12, left: 12),
      shrinkWrap: true,
      primary: false,
      crossAxisSpacing: 18,
      mainAxisSpacing: 18,
      childAspectRatio: 1 / 1.2,
      crossAxisCount: 3,
      children: List.generate(
        4,
        (index) {
          List<String> imagePathList = [
            "assets/images/knowledge.svg",
            "assets/images/law.svg",
            "assets/images/history.svg",
            "assets/images/relax.svg"
          ];
          List<TypeOfBooks> typeOfBookList = [
            TypeOfBooks.knowledge,
            TypeOfBooks.law,
            TypeOfBooks.history,
            TypeOfBooks.relax,
          ];
          return CategoryItem(
            amount: DummyData.booksList
                .map((item) => BookModel.fromJson(item))
                .toList()
                .where((element) => element.category == typeOfBookList[index])
                .toList()
                .length,
            imagePath: imagePathList[index],
            typeOfBooks: typeOfBookList[index],
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategoryDetailPage(
                  typeOfBooks: typeOfBookList[index],
                  bookList: DummyData.booksList
                      .map((item) => BookModel.fromJson(item))
                      .toList()
                      .where((element) =>
                          element.category == typeOfBookList[index])
                      .toList(),
                ),
              ));
            },
          );
        },
      ),
    );
  }
}
