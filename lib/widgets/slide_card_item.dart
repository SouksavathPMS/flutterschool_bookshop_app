import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterschool_bookshop_app/models/book_model.dart';
import 'package:flutterschool_bookshop_app/utils/utils.dart';

import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';

class BookCardItem extends StatefulWidget {
  const BookCardItem({
    super.key,
    required this.width,
    this.isHasBottomSection = false,
    this.bookDetail,
    this.initialAmount = 1,
    this.increateAmountCallback,
    required this.index,
  });

  final double width;
  final bool isHasBottomSection;
  final BookModel? bookDetail;
  final int initialAmount;
  final Function? increateAmountCallback;
  final int index;

  @override
  State<BookCardItem> createState() => _BookCardItemState();
}

class _BookCardItemState extends State<BookCardItem> {
  int bookAmount = 1;
  @override
  void initState() {
    bookAmount = widget.initialAmount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: widget.width * .85,
      decoration: BoxDecoration(
        color: ConstantColor.grey.withOpacity(.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Expanded(
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
                      child: Image.network(
                        widget.bookDetail == null
                            ? "https://m.media-amazon.com/images/I/81bGKUa1e0L._AC_UF1000,1000_QL80_.jpg"
                            : widget.bookDetail!.imageUrl,
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
                            child: Text(
                              widget.bookDetail == null
                                  ? 'Birnam Wood, by Eleanor Catton'
                                  : "${widget.bookDetail!.title}, by ${widget.bookDetail!.author}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
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
                            child: Text(
                              widget.bookDetail == null
                                  ? 'In this action-packed novel from a Booker Prize winner, a collective of activist hello activity'
                                  : widget.bookDetail!.smallDetail,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
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
                              widget.bookDetail == null
                                  ? 4
                                  : widget.bookDetail!.rating,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.isHasBottomSection) ...[
            // const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "  ລາຄາ : ",
                        style: const TextStyle(
                          fontFamily: "NotoSansLao",
                          color: ConstantColor.grey,
                          fontSize: ConstantFontSize.headerSize3,
                        ),
                        children: [
                          TextSpan(
                            text: widget.bookDetail == null
                                ? "150,000 LAK"
                                : "${Utils.getCurrency(widget.bookDetail!.price)} LAK",
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
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (bookAmount > 1) {
                            bookAmount--;
                            if (widget.increateAmountCallback != null) {
                              widget.increateAmountCallback!(
                                  widget.index, bookAmount);
                            }
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
                          if (widget.increateAmountCallback != null) {
                            widget.increateAmountCallback!(
                                widget.index, bookAmount);
                          }
                        });
                      },
                      child: const Icon(
                        Icons.add_circle_outline_rounded,
                        size: 38,
                      ),
                    )
                  ],
                )
              ],
            )
          ]
        ],
      ),
    );
  }
}
