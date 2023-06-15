import 'package:flutter/cupertino.dart';

import '../constants/constant_colors.dart';
import '../constants/constant_font_size.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: ConstantFontSize.headerSizeNormal,
        fontWeight: FontWeight.bold,
        color: ConstantColor.grey,
      ),
    );
  }
}
