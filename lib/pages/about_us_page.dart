import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';

import '../constants/constant_font_size.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
          "ກ່ຽວກັບພວກເຮົາ",
          style: TextStyle(
            color: ConstantColor.darkGrey,
            fontSize: ConstantFontSize.headerSizeBig,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, right: 12, left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                AboutUsAvatar(
                  isSmall: false,
                  title: "ປອ ສະຫວາດ ໄຊປະດິດ",
                  responsibility: "ຜູ້ນຳພາ",
                  imagePath: "assets/images/arjarn.jpeg",
                ),
                SizedBox(height: 10),
                Divider(
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ກຸ່ມ 07",
                      style: TextStyle(
                        color: ConstantColor.grey,
                        fontSize: ConstantFontSize.headerSize3,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      "4COM1",
                      style: TextStyle(
                        color: ConstantColor.grey,
                        fontSize: ConstantFontSize.headerSize3,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: AboutUsAvatar(
                        isSmall: true,
                        title: "ທ. ສຸກສະຫວັດ ພົມມະແສງ",
                        responsibility: "ຫົວໜ້າກຸ່ມ",
                        imagePath: "assets/images/souksavath.jpeg",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: AboutUsAvatar(
                        isSmall: true,
                        title: "ທ. ສອນ ສີດາວັນ",
                        responsibility: "ສະມາຊິກ",
                        imagePath: "assets/images/sone.jpeg",
                      ),
                    ),
                    Expanded(
                      child: AboutUsAvatar(
                        isSmall: true,
                        title: "ນ. ຈີດາວັນ ໄຊຍະແສງ",
                        responsibility: "ສະມາຊິກ",
                        imagePath: "assets/images/jee.jpeg",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AboutUsAvatar(
                        isSmall: true,
                        title: "ທ. ຂັນຕິໄຊ ສຸລິຍະວົງ",
                        responsibility: "ສະມາຊິກ",
                        imagePath: "assets/images/eikq.jpeg",
                      ),
                    ),
                    Expanded(
                      child: AboutUsAvatar(
                        isSmall: true,
                        title: "ນ. ດາວນິນ ພະສະຫວັດ",
                        responsibility: "ສະມາຊິກ",
                        imagePath: "assets/images/daownin.jpeg",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AboutUsAvatar(
                        isSmall: true,
                        title: "ທ. ບຸນຖົມ ແພງສີ",
                        responsibility: "ສະມາຊິກ",
                      ),
                    ),
                    Expanded(child: SizedBox())
                  ],
                ),
                SizedBox(height: 12),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AboutUsAvatar extends StatelessWidget {
  const AboutUsAvatar({
    super.key,
    this.isSmall = true,
    required this.responsibility,
    required this.title,
    this.imagePath = "assets/images/user_avatar.png",
  });
  final bool isSmall;
  final String title;
  final String responsibility;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: ConstantColor.darkGrey.withOpacity(.3),
                blurRadius: 6,
                spreadRadius: 0,
                offset: const Offset(2, 2), // Shadow position
              ),
            ],
          ),
          child: CircleAvatar(
            radius: isSmall ? 35 : 45,
            backgroundImage: AssetImage(imagePath),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: isSmall
                ? ConstantFontSize.headerSize
                : ConstantFontSize.headerSizeNormal,
            fontWeight: FontWeight.bold,
            color: ConstantColor.grey,
          ),
        ),
        Text(
          responsibility,
          style: TextStyle(
            color: ConstantColor.grey,
            fontSize: isSmall
                ? ConstantFontSize.headerSize6
                : ConstantFontSize.headerSize6,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}
