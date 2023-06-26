import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterschool_bookshop_app/hive_models/add_fav_model.dart';
import 'package:flutterschool_bookshop_app/utils/utils.dart';

import '../common/custom_cart_badge.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';
import '../constants/dummy_data.dart';
import '../constants/hive_box.dart';
import '../models/book_model.dart';
import '../services/local_database_service.dart';
import '../widgets/main_button.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({
    super.key,
    this.bookId = "c607cd7b-30c1-4d65-9cc7-35a4865c5212",
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
                  Expanded(
                    flex: 5,
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
                                  onTap: () {
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
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isFav = !isFav;
                                });
                                if (isFav) {
                                  final addFavInfo =
                                      AddFavModel(bookId: widget.bookId);
                                  await LocalDatabaseService.instance
                                      .add<AddFavModel>(
                                          HiveBox.addFav, addFavInfo);
                                } else {
                                  
                                }
                              },
                              child: Icon(
                                Icons.favorite,
                                size: 30,
                                color: isFav
                                    ? ConstantColor.primaryColor
                                    : ConstantColor.grey.withOpacity(.4),
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
                  title: "ສັ່ງຊື້ປື້ມຈຳນວນ : $bookAmount",
                  onPressed: () {},
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
