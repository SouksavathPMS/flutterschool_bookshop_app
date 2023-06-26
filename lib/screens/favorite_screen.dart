import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';
import 'package:flutterschool_bookshop_app/widgets/main_button.dart';
import 'package:flutterschool_bookshop_app/widgets/slide_card_item.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final bookCheckList = List.generate(3, (index) => false);
  final bookFavList = List.generate(3, (index) => true);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                Stack(
                  children: [
                    BookCardItem(
                      width: width * .96,
                      isHasBottomSection: true,
                    ),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Transform.rotate(
                        angle: 20 * pi / 180,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              bookFavList[index] = !bookFavList[index];
                            });
                          },
                          child: Icon(
                            Icons.favorite,
                            size: 30,
                            color: bookFavList[index]
                                ? ConstantColor.primaryColor
                                : ConstantColor.grey.withOpacity(.4),
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
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: bookCheckList.length,
      ),
      floatingActionButton: MainButton(
        title: "+ ສັ່ງຊື້",
        onPressed: () {},
      ),
    );
  }
}
