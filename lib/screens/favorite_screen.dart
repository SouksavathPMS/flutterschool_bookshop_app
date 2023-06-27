// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';
import 'package:flutterschool_bookshop_app/constants/hive_box.dart';
import 'package:flutterschool_bookshop_app/dialogs/remove_fav_dialog.dart';
import 'package:flutterschool_bookshop_app/services/local_database_service.dart';
import 'package:flutterschool_bookshop_app/widgets/display_box_widget.dart';
import 'package:flutterschool_bookshop_app/widgets/main_button.dart';
import 'package:flutterschool_bookshop_app/widgets/slide_card_item.dart';
import 'package:hive/hive.dart';

import '../constants/dummy_data.dart';
import '../dialogs/generic_dialogs.dart';
import '../hive_models/add_fav_model.dart';
import '../hive_models/add_to_cart_model.dart';
import '../models/book_model.dart';
import '../pages/book_detail_page.dart';
import '../pages/cart_page.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final bookCheckList = List.generate(
      Hive.box<AddFavModel>(HiveBox.addFav.name).values.length,
      (idx) => [
            false,
            Hive.box<AddFavModel>(HiveBox.addFav.name)
                .values
                .toList()[idx]
                .bookId,
            1,
            Hive.box<AddFavModel>(HiveBox.addFav.name)
                .values
                .toList()[idx]
                .price,
          ]);

  void increateAmountCallBack(int index, int amount) {
    setState(() {
      bookCheckList[index][2] = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DisplayBoxWidget<AddFavModel>(
      hiveBox: HiveBox.addFav,
      child: (context, data) => Scaffold(
        body: data.isEmpty || bookCheckList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: ConstantColor.primaryColor.withOpacity(.3),
                    ),
                    const SizedBox(height: 6),
                    const Text("ບໍ່ມີລາຍການປື້ມທີ່ທ່ານມັກ"),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.only(
                    top: 10, right: 12, left: 12, bottom: 80),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final favBook = data[index];
                  // print(bookCheckList);
                  return SizedBox(
                    height: 193,
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: ConstantColor.mainColor,
                          value: bookCheckList.isEmpty
                              ? null
                              : bookCheckList[index][0] as bool,
                          onChanged: (value) {
                            setState(() {
                              bookCheckList[index][0] = value!;
                            });
                          },
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        BookDetailPage(bookId: favBook.bookId),
                                  ),
                                );
                              },
                              child: BookCardItem(
                                increateAmountCallback: increateAmountCallBack,
                                index: index,
                                width: width * .96,
                                isHasBottomSection: true,
                                bookDetail: DummyData.booksList
                                    .map((item) => BookModel.fromJson(item))
                                    .toList()
                                    .firstWhere((element) =>
                                        element.id == favBook.bookId),
                              ),
                            ),
                            Positioned(
                              right: 4,
                              top: 4,
                              child: Transform.rotate(
                                angle: 20 * pi / 180,
                                child: GestureDetector(
                                  onTap: () async {
                                    final confirmDelete =
                                        await reMoveFavDialog(context);
                                    if (!confirmDelete) {
                                      return;
                                    }
                                    LocalDatabaseService.instance
                                        .deleteAt<AddFavModel>(
                                            HiveBox.addFav, index);
                                  },
                                  child: const Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: ConstantColor.primaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: data.length,
              ),
        floatingActionButton: data.isEmpty || bookCheckList.isEmpty
            ? null
            : DisplayBoxWidget<AddToCartModel>(
                hiveBox: HiveBox.addTocart,
                child: (context, data) => MainButton(
                  title: "+ ເພີ່ມເຂົ້າລາຍການສັ່ງຊື້",
                  onPressed: () async {
                    final toAddList = bookCheckList
                        .where(
                          (element) => element[0] as bool == true,
                        )
                        .toList();

                    for (var element in toAddList) {
                      final toAddToCartInfo = AddToCartModel(
                        bookId: element[1].toString(),
                        amount: element[2] as int,
                        price: element[3] as int,
                      );
                      final aleadyIncartList =
                          Hive.box<AddToCartModel>(HiveBox.addTocart.name)
                              .values
                              .toList();

                      if (aleadyIncartList.contains(toAddToCartInfo)) {
                        final oldData = aleadyIncartList.firstWhere(
                          (item) => item == toAddToCartInfo,
                          orElse: () => AddToCartModel(
                              bookId: "N/A", amount: 0, price: 0),
                        );

                        final toAddToCart = AddToCartModel(
                          bookId: element[1].toString(),
                          amount: (element[2] as int) + oldData.amount,
                          price: element[3] as int,
                        );

                        await LocalDatabaseService.instance
                            .putAt<AddToCartModel>(
                                HiveBox.addTocart,
                                aleadyIncartList.indexOf(
                                  aleadyIncartList.firstWhere(
                                    (element) => element == toAddToCartInfo,
                                    orElse: () => AddToCartModel(
                                        bookId: "N/A", amount: 0, price: 0),
                                  ),
                                ),
                                toAddToCart);
                      } else {
                        await LocalDatabaseService.instance.add<AddToCartModel>(
                            HiveBox.addTocart, toAddToCartInfo);
                      }
                    }

                    final isTrue = await showGenericDialog<bool>(
                        context: context,
                        title: "ສຳເລັດ",
                        content:
                            'ເພີ່ມເຂົ້າກະຕ່າສຳເລັດກົດ"ຕົກລົງ"ເພື່ອສຳເລັດການສັ່ງຊື້',
                        optionsBuilder: () => {
                              "ຍົກເລີກ": false,
                              "ຕົກລົງ": true,
                            });

                    if (isTrue!) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    } else {
                      return;
                    }
                  },
                ),
              ),
      ),
    );
  }
}
