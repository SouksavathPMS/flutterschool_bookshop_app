// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterschool_bookshop_app/hive_models/add_fav_model.dart';
import 'package:flutterschool_bookshop_app/hive_models/add_to_cart_model.dart';
import 'package:flutterschool_bookshop_app/utils/utils.dart';
import 'package:flutterschool_bookshop_app/widgets/display_box_widget.dart';
import 'package:hive/hive.dart';

import '../common/custom_cart_badge.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';
import '../constants/dummy_data.dart';
import '../constants/hive_box.dart';
import '../dialogs/generic_dialogs.dart';
import '../models/book_model.dart';
import '../services/local_database_service.dart';
import '../widgets/main_button.dart';
import 'cart_page.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({
    super.key,
    required this.bookId,
  });

  final String bookId;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int bookAmount = 1;
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final aBook = DummyData.booksList
        .map((item) => BookModel.fromJson(item))
        .toList()
        .firstWhere((element) => element.id == widget.bookId);
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
          "ລາຍລະອຽດກ່ຽວກັບປື້ມ",
          style: TextStyle(
            color: ConstantColor.darkGrey,
            fontSize: ConstantFontSize.headerSizeBig,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10, right: 12, left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // color: Colors.amber,
              height: 210,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ConstantColor.darkGrey.withOpacity(.3),
                          blurRadius: 6,
                          spreadRadius: 0,
                          offset: const Offset(-4, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: Image.network(
                      aBook.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 22),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              aBook.category.value,
                              style: const TextStyle(
                                color: ConstantColor.grey,
                                fontSize: ConstantFontSize.headerSize6,
                                // height: 1.2,
                              ),
                            ),
                            Row(
                              children: [
                                ...List.generate(
                                  aBook.rating,
                                  (index) => ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 14,
                                    ),
                                    child: const Icon(
                                      Icons.star_rate_rounded,
                                      size: 16,
                                      color: ConstantColor.grey,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 6),
                        Flexible(
                          child: SizedBox(
                            child: Text(
                              '${aBook.title}, by ${aBook.author}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                              style: const TextStyle(
                                color: ConstantColor.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: ConstantFontSize.headerSize3,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Spacer(),
                        RichText(
                          text: TextSpan(
                            text: "ລາຄາ : ",
                            style: const TextStyle(
                              fontFamily: "NotoSansLao",
                              color: ConstantColor.grey,
                              fontSize: ConstantFontSize.headerSize3,
                            ),
                            children: [
                              TextSpan(
                                text: "${Utils.getCurrency(aBook.price)} LAK",
                                style: const TextStyle(
                                  fontFamily: "NotoSansLao",
                                  color: ConstantColor.grey,
                                  fontSize: ConstantFontSize.headerSize3,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (bookAmount > 1) {
                                        bookAmount--;
                                      }
                                    });
                                  },
                                  child: SizedBox(
                                    height: 37,
                                    width: 37,
                                    child: SvgPicture.asset(
                                      "assets/images/minus-round-svgrepo-com.svg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  bookAmount.toString(),
                                  style: const TextStyle(
                                    color: ConstantColor.grey,
                                    fontSize: ConstantFontSize.headerSize3,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: () async {
                                    LocalDatabaseService.instance;
                                    setState(() {
                                      bookAmount++;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.add_circle_outline_rounded,
                                    size: 38,
                                  ),
                                )
                              ],
                            ),
                            DisplayBoxWidget<AddFavModel>(
                              hiveBox: HiveBox.addFav,
                              child: (context, data) => GestureDetector(
                                onTap: () async {
                                  if (!data
                                      .map((e) => e.bookId)
                                      .contains(aBook.id.toString())) {
                                    final addFavInfo = AddFavModel(
                                        bookId: widget.bookId,
                                        price: aBook.price);
                                    await LocalDatabaseService.instance
                                        .add<AddFavModel>(
                                            HiveBox.addFav, addFavInfo);
                                  } else {
                                    List<AddFavModel> newWithDeleteList = data
                                        .map((e) => e)
                                        .where((element) =>
                                            element.bookId != widget.bookId)
                                        .toList();

                                    await LocalDatabaseService.instance
                                        .deleteAll<AddFavModel>(
                                            HiveBox.addFav, data);

                                    for (var element in newWithDeleteList) {
                                      await LocalDatabaseService.instance
                                          .add<AddFavModel>(
                                              HiveBox.addFav, element);
                                    }
                                  }
                                },
                                child: Icon(
                                  Icons.favorite,
                                  size: 30,
                                  color: data
                                          .map((e) => e.bookId)
                                          .contains(aBook.id.toString())
                                      ? ConstantColor.primaryColor
                                      : ConstantColor.grey.withOpacity(.4),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Why should you read this book?',
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
              style: TextStyle(
                color: ConstantColor.grey,
                fontWeight: FontWeight.bold,
                fontSize: ConstantFontSize.headerSize3,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 2.5,
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  height: 65,
                  decoration: BoxDecoration(
                    color: ConstantColor.grey.withOpacity(.5),
                  ),
                ),
                Flexible(
                  child: Text(
                    ' ${aBook.smallDetail}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(
                      color: ConstantColor.grey,
                      fontSize: ConstantFontSize.headerSize4,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '  ${aBook.description}',
              overflow: TextOverflow.ellipsis,
              maxLines: 100,
              style: const TextStyle(
                color: ConstantColor.grey,
                fontSize: ConstantFontSize.headerSize4,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10, right: 12, left: 12),
        height: 90,
        decoration: BoxDecoration(
          color: ConstantColor.white,
          boxShadow: [
            BoxShadow(
              color: ConstantColor.darkGrey.withOpacity(.1),
              blurRadius: 6,
              spreadRadius: 0,
              offset: const Offset(0, .05), // Shadow position
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: MainButton(
                  title: "ເພີ່ມເຂົ້າລາຍການສັ່ງຊື່ຈຳນວນ : $bookAmount",
                  onPressed: () async {
                    final addToCartInfo = AddToCartModel(
                      bookId: widget.bookId,
                      amount: bookAmount,
                      price: aBook.price,
                    );
                    final aleadyIncartList =
                        Hive.box<AddToCartModel>(HiveBox.addTocart.name)
                            .values
                            .toList();

                    if (aleadyIncartList.contains(addToCartInfo)) {
                      final oldData = aleadyIncartList.firstWhere(
                        (element) => element == addToCartInfo,
                        orElse: () =>
                            AddToCartModel(bookId: "N/A", amount: 0, price: 0),
                      );
                      final toAddToCartInfo = AddToCartModel(
                        bookId: widget.bookId,
                        amount: oldData.amount + bookAmount,
                        price: aBook.price,
                      );
                      await LocalDatabaseService.instance.putAt<AddToCartModel>(
                          HiveBox.addTocart,
                          aleadyIncartList.indexOf(
                            aleadyIncartList.firstWhere(
                              (element) => element == addToCartInfo,
                              orElse: () => AddToCartModel(
                                bookId: "N/A",
                                amount: 0,
                                price: aBook.price,
                              ),
                            ),
                          ),
                          toAddToCartInfo);
                    } else {
                      await LocalDatabaseService.instance
                          .add<AddToCartModel>(HiveBox.addTocart, addToCartInfo)
                          .then((_) async {
                        bookAmount = 1;
                      });
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

                    // print(aleadyIncartList
                    //     .where((element) => element == addToCartInfo));
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomCartBadge(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
