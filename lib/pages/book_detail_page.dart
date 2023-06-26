import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../common/custom_cart_badge.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';
import '../widgets/main_button.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int bookAmount = 1;
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
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
                    child: Image.asset(
                      "assets/images/book_sample.png",
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
                            const Text(
                              "ຄວາມຮູ້",
                              style: TextStyle(
                                color: ConstantColor.grey,
                                fontSize: ConstantFontSize.headerSize6,
                                // height: 1.2,
                              ),
                            ),
                            Row(
                              children: [
                                ...List.generate(
                                  4,
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
                        const Flexible(
                          child: SizedBox(
                            child: Text(
                              'Birnam Wood, by Eleanor Catton',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                              style: TextStyle(
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
                          text: const TextSpan(
                            text: "ລາຄາ : ",
                            style: TextStyle(
                              fontFamily: "NotoSansLao",
                              color: ConstantColor.grey,
                              fontSize: ConstantFontSize.headerSize3,
                            ),
                            children: [
                              TextSpan(
                                text: "150,000 LAK",
                                style: TextStyle(
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
                              onTap: () {
                                setState(() {
                                  isFav = !isFav;
                                });
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
                const Flexible(
                  child: Text(
                    ' An atomic habit is a little habit that is part of a larger system. Just as atoms are the building blocks of molecules, atomic habits are the building blocks of remarkable results. James Clear',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(
                      color: ConstantColor.grey,
                      fontSize: ConstantFontSize.headerSize4,
                      height: 1.2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              '  The book offers this approach —without thinking much about the goal, focus on the system. The idea is not new, but it’s quite detailed in the book. Small changes often appear to make no difference until you cross a critical threshold. The most powerful outcomes of any compounding process are delayed. You need to be patient.Atomic Habits: Tiny Changes, Remarkable ResultsJames Clear. It equally applies to learning a new language, eating healthy, career transitioning, working out, writing a book, and managing a household. When you are focused on the goal, improvements are temporary. If you want to maintain this improvement, it should become part of who you are. The book offers this approach —without thinking much about the goal, focus on the system. The idea is not new, but it’s quite detailed in the book. Small changes often appear to make no difference until you cross a critical threshold. The most powerful outcomes of any compounding process are delayed. You need to be patient.Atomic Habits: Tiny Changes, Remarkable ResultsJames Clear. It equally applies to learning a new language, eating healthy, career transitioning, working out, writing a book, and managing a household. When you are focused on the goal, improvements are temporary. If you want to maintain this improvement, it should become part of who you are.',
              overflow: TextOverflow.ellipsis,
              maxLines: 100,
              style: TextStyle(
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
