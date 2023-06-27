// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'add_fav_model.g.dart';

@HiveType(typeId: 0)
class AddFavModel {
  @HiveField(0)
  final String bookId;
  @HiveField(1)
  final int price;

  AddFavModel({
    required this.bookId,
    required this.price,
  });
}
