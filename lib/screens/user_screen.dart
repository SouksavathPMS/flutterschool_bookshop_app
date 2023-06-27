import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/dummy_data.dart';
import 'package:flutterschool_bookshop_app/constants/hive_box.dart';
import 'package:flutterschool_bookshop_app/hive_models/order_model.dart';
import 'package:flutterschool_bookshop_app/pages/about_us_page.dart';
import 'package:flutterschool_bookshop_app/widgets/display_box_widget.dart';

import '../common/custom_title.dart';
import 'package:badges/badges.dart' as badges;

import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';
import '../models/book_model.dart';
import '../models/booktype_model_test.dart';
import '../pages/book_detail_page.dart';
import '../utils/utils.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final bookCheckList = DummyData.textBookType
      .map((item) => BookTypeModelTest.fromMap(item))
      .toList();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 10, right: 12, left: 12),
      child: DisplayBoxWidget<OrderModel>(
        hiveBox: HiveBox.order,
        child: (context, data) => Column(
          children: [
            BooksUserPurchedSection(
              width: width,
              bookOrder: data
                  .where((element) => element.orderDate.isAfter(DateTime.now()))
                  .toList(),
              title: "ກຳລັງສັ່ງຊື້",
              isHasRightIcon: true,
            ),
            const SizedBox(height: 10),
            BooksUserPurchedSection(
              width: width,
              bookOrder: data
                  .where(
                      (element) => element.orderDate.isBefore(DateTime.now()))
                  .toList(),
              title: "ຊື້ສຳເລັດ",
            ),
            const SizedBox(height: 6),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              },
              child: const CustomTitle(title: "ກ່ຽວກັບຜູ້ພັດທະນາ"),
            )
          ],
        ),
      ),
    );
  }
}

class BooksUserPurchedSection extends StatelessWidget {
  const BooksUserPurchedSection({
    super.key,
    required this.width,
    required this.title,
    required this.bookOrder,
    this.isHasRightIcon = false,
  });

  final double width;
  final List<OrderModel> bookOrder;
  final String title;
  final bool isHasRightIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTitle(title: title),
            const SizedBox(height: 6),
            if (isHasRightIcon)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: badges.Badge(
                  badgeAnimation: const badges.BadgeAnimation.scale(),
                  badgeContent: Text(
                    "${bookOrder.length}",
                    style: const TextStyle(
                      color: ConstantColor.white,
                    ),
                  ),
                  position: badges.BadgePosition.custom(start: 20, bottom: 10),
                  child: const Icon(
                    Icons.local_shipping_outlined,
                    color: ConstantColor.darkGrey,
                  ),
                ),
              )
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 270,
          child: bookOrder.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: ConstantColor.primaryColor.withOpacity(.3),
                      ),
                      const SizedBox(height: 6),
                      isHasRightIcon
                          ? const Text("ບໍ່ມີລາຍການປື້ມທີ່ສັ່ງຊື້")
                          : const Text("ບໍ່ມີລາຍການປື້ມທີ່ຊື້ສຳເລັດ"),
                    ],
                  ),
                )
              : ListView.separated(
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final aBook = DummyData.booksList
                        .map((item) => BookModel.fromJson(item))
                        .toList()
                        .firstWhere(
                            (element) => element.id == bookOrder[index].bookId);
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
                      child: Stack(
                        children: [
                          SizedBox(
                            width: width * .28,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Image.network(
                                    aBook.imageUrl,
                                  ),
                                ),
                                const SizedBox(height: 5.5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      aBook.category.value,
                                      style: const TextStyle(
                                        color: ConstantColor.grey,
                                        fontSize: ConstantFontSize.headerSize6,
                                        height: 1.2,
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
                                      style: TextStyle(
                                        color: isHasRightIcon
                                            ? ConstantColor.primaryColor
                                            : Colors.green,
                                        fontSize: ConstantFontSize.headerSize5,
                                        // height: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: isHasRightIcon
                                    ? ConstantColor.primaryColor.withOpacity(.6)
                                    : Colors.green.withOpacity(.6),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                "x${bookOrder[index].amount}",
                                style: const TextStyle(
                                  color: ConstantColor.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ConstantFontSize.headerSize3,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemCount: bookOrder.length),
        ),
      ],
    );
  }
}
