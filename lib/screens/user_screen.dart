import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/dummy_data.dart';
import 'package:flutterschool_bookshop_app/pages/about_us_page.dart';

import '../common/custom_title.dart';
import 'package:badges/badges.dart' as badges;

import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';
import '../models/booktype_model_test.dart';

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTitle(title: "ກຳລັງສັ່ງຊື້"),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: badges.Badge(
                  badgeAnimation: const badges.BadgeAnimation.scale(),
                  badgeContent: const Text(
                    "0",
                    style: TextStyle(
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
            height: 240,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(
                      width: width * .28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Image.asset(
                              "assets/images/book_sample.png",
                            ),
                          ),
                          const SizedBox(height: 5.5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                bookCheckList[index].bookType.value,
                                style: const TextStyle(
                                  color: ConstantColor.grey,
                                  fontSize: ConstantFontSize.headerSize6,
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                bookCheckList[index].bookType.value +
                                    bookCheckList[index].bookType.name +
                                    bookCheckList[index].bookType.value +
                                    bookCheckList[index].bookType.name,
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
                                bookCheckList[index].bookType.value,
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
                    ),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: bookCheckList.length),
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              CustomTitle(title: "ຊື້ສຳເລັດ"),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 240,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(
                      width: width * .28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Image.asset(
                              "assets/images/book_sample.png",
                            ),
                          ),
                          const SizedBox(height: 5.5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                bookCheckList[index].bookType.value,
                                style: const TextStyle(
                                  color: ConstantColor.grey,
                                  fontSize: ConstantFontSize.headerSize6,
                                  height: 1.2,
                                ),
                              ),
                              Text(
                                bookCheckList[index].bookType.value +
                                    bookCheckList[index].bookType.name +
                                    bookCheckList[index].bookType.value +
                                    bookCheckList[index].bookType.name,
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
                                bookCheckList[index].bookType.value,
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
                    ),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: bookCheckList.length),
          ),
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
    );
  }
}
