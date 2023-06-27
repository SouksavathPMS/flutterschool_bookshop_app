import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/hive_box.dart';

/// re-use display hive box data
class DisplayBoxWidget<T> extends StatelessWidget {
  final HiveBox hiveBox;
  final Widget Function(BuildContext context, List<T> data) child;
  const DisplayBoxWidget({
    super.key,
    required this.hiveBox,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<T>>(
      valueListenable: Hive.box<T>(hiveBox.name).listenable(),
      builder: (context, box, widget) {
        List<T> data = box.values.toList();
        return child(context, data);
      },
    );
  }
}
