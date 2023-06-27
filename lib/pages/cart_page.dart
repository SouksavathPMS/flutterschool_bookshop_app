import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';
import 'package:flutterschool_bookshop_app/constants/hive_box.dart';
import 'package:flutterschool_bookshop_app/dialogs/comfirm_delete_form_cart_dioalog.dart';
import 'package:flutterschool_bookshop_app/hive_models/add_to_cart_model.dart';
import 'package:flutterschool_bookshop_app/services/local_database_service.dart';
import 'package:flutterschool_bookshop_app/utils/utils.dart';
import 'package:flutterschool_bookshop_app/widgets/display_box_widget.dart';
import 'package:hive/hive.dart';

import '../constants/constant_font_size.dart';
import '../constants/dummy_data.dart';
import '../models/book_model.dart';
import '../widgets/main_button.dart';
import '../widgets/slide_card_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final bookCheckList = List.generate(
    Hive.box<AddToCartModel>(HiveBox.addTocart.name).length,
    (index) => [
      true,
      Hive.box<AddToCartModel>(HiveBox.addTocart.name)
          .values
          .toList()[index]
          .bookId,
      Hive.box<AddToCartModel>(HiveBox.addTocart.name)
          .values
          .toList()[index]
          .amount,
      Hive.box<AddToCartModel>(HiveBox.addTocart.name)
          .values
          .toList()[index]
          .price,
    ],
  );
  // final amountList = Hive.box<AddToCartModel>(HiveBox.addTocart.name)
  //     .values
  //     .map((e) => e.amount)
  //     .toList();

  final List<int> toDeleteIndex = List.generate(
      Hive.box<AddToCartModel>(HiveBox.addTocart.name).length,
      (index) => index);

  void increateAmountCallBack(int index, int amount) {
    setState(() {
      bookCheckList[index][2] = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return DisplayBoxWidget<AddToCartModel>(
        hiveBox: HiveBox.addTocart,
        child: (context, data) {
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
                "ສະຕ່າຂອງທ່ານ",
                style: TextStyle(
                  color: ConstantColor.darkGrey,
                  fontSize: ConstantFontSize.headerSizeBig,
                ),
              ),
            ),
            body: data.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: ConstantColor.primaryColor.withOpacity(.3),
                        ),
                        const SizedBox(height: 6),
                        const Text("ບໍ່ມີລາຍການປື້ມໃນລາຍການສັ່ງຊື້"),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.only(
                        top: 10, right: 12, left: 12, bottom: 80),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final bookItem = data[index];
                      return SizedBox(
                        height: 193,
                        child: Row(
                          children: [
                            DisplayBoxWidget<AddToCartModel>(
                              hiveBox: HiveBox.addTocart,
                              child: (context, data) {
                                return Checkbox(
                                  key: UniqueKey(),
                                  activeColor: ConstantColor.mainColor,
                                  value: bookCheckList[index][0] as bool,
                                  onChanged: (value) {
                                    if (value!) {
                                      toDeleteIndex.add(index);
                                      // amountList.insert(index, element);
                                    } else {
                                      // amountList.removeAt(index);
                                      toDeleteIndex.remove(index);
                                    }
                                    setState(() {
                                      bookCheckList[index][0] = value;
                                    });
                                  },
                                );
                              },
                            ),
                            BookCardItem(
                              increateAmountCallback: increateAmountCallBack,
                              index: index,
                              initialAmount: bookItem.amount,
                              width: width * .96,
                              isHasBottomSection: true,
                              bookDetail: DummyData.booksList
                                  .map((item) => BookModel.fromJson(item))
                                  .toList()
                                  .firstWhere((element) =>
                                      element.id == bookItem.bookId),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: data.length,
                  ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.only(top: 10, right: 12, left: 12),
              height: 124,
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
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "ທັງໝົດ : ",
                            style: const TextStyle(
                              fontFamily: "NotoSansLao",
                              color: ConstantColor.grey,
                              fontSize: ConstantFontSize.headerSize,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "${Utils.getCurrency(bookCheckList.where((element) => element[0] as bool == true).map((e) => int.parse(e[3].toString()) * int.parse(e[2].toString())).toList().fold(0, (previousValue, element) => previousValue + (element)))} LAK",
                                // text: "300,000 LAK",
                                style: const TextStyle(
                                  fontFamily: "NotoSansLao",
                                  color: ConstantColor.grey,
                                  fontSize: ConstantFontSize.headerSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "ຈຳນວນ : ",
                            style: const TextStyle(
                              fontFamily: "NotoSansLao",
                              color: ConstantColor.grey,
                              fontSize: ConstantFontSize.headerSize,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "${bookCheckList.where((element) => element[0] as bool == true).map((e) => e[2]).toList().fold(0, (previousValue, element) => previousValue + (element as int))} ຫົວ",
                                style: const TextStyle(
                                  fontFamily: "NotoSansLao",
                                  color: ConstantColor.grey,
                                  fontSize: ConstantFontSize.headerSize,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final isDelete =
                                await comfirmDeleteFormCartDialog(context);
                            if (!isDelete) {
                              return;
                            }
                            for (var element in toDeleteIndex) {
                              LocalDatabaseService.instance
                                  .deleteAt<AddToCartModel>(
                                      HiveBox.addTocart, element);
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  size: 28,
                                  color: ConstantColor.grey,
                                ),
                                Text(
                                  "ລົບທີ່ເລືອກ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ConstantColor.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: MainButton(
                            title: "ສຳເລັດການສັ່ງຊື້ຕາມທີ່ເລືອກ",
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
