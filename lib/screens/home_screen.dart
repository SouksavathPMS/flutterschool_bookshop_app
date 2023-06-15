import 'package:flutter/material.dart';

import '../common/custom_title.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 12, left: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomTitle(title: "ປື້ມແນະນຳ"),
              GestureDetector(
                onTap: () {},
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
              itemCount: 8,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 153,
                width: width * .85,
                decoration: BoxDecoration(
                  color: ConstantColor.grey.withOpacity(.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
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
                          child: Image.asset(
                            "assets/images/book_sample.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.only(left: 3),
                                child: const Text(
                                  'Birnam Wood, by Eleanor Catton',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: ConstantColor.grey,
                                    fontSize: ConstantFontSize.headerSize3,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.only(left: 3),
                                child: const Text(
                                  'In this action-packed novel from a Booker Prize winner, a collective of activist hello activity',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: ConstantColor.grey,
                                    fontSize: ConstantFontSize.headerSize6,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  4,
                                  (index) => ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      maxWidth: 14,
                                    ),
                                    child: const Icon(
                                      Icons.star_rate_rounded,
                                      size: 18,
                                      color: ConstantColor.grey,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
