import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';

import '../constants/constant_font_size.dart';
import '../widgets/main_button.dart';
import '../widgets/slide_card_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final bookCheckList = List.generate(3, (index) => false);

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
          "ສະຕ່າຂອງທ່ານ",
          style: TextStyle(
            color: ConstantColor.darkGrey,
            fontSize: ConstantFontSize.headerSizeBig,
          ),
        ),
      ),
      body: ListView.separated(
        padding:
            const EdgeInsets.only(top: 10, right: 12, left: 12, bottom: 80),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 193,
            child: Row(
              children: [
                Checkbox(
                  activeColor: ConstantColor.mainColor,
                  value: bookCheckList[index],
                  onChanged: (value) {
                    setState(() {
                      bookCheckList[index] = value!;
                    });
                  },
                ),
                BookCardItem(
                  width: width * .96,
                  isHasBottomSection: true,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: bookCheckList.length,
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
                    text: const TextSpan(
                      text: "ທັງໝົດ : ",
                      style: TextStyle(
                        fontFamily: "NotoSansLao",
                        color: ConstantColor.grey,
                        fontSize: ConstantFontSize.headerSize,
                      ),
                      children: [
                        TextSpan(
                          text: "300,000 LAK",
                          style: TextStyle(
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
                    text: const TextSpan(
                      text: "ຈຳນວນ : ",
                      style: TextStyle(
                        fontFamily: "NotoSansLao",
                        color: ConstantColor.grey,
                        fontSize: ConstantFontSize.headerSize,
                      ),
                      children: [
                        TextSpan(
                          text: "2 ຫົວ",
                          style: TextStyle(
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
                  Expanded(
                    child: MainButton(
                      title: "ສຳເລັດການສັ່ງຊື້",
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
  }
}
