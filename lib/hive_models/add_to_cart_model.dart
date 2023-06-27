// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'add_to_cart_model.g.dart';

@HiveType(typeId: 1)
class AddToCartModel {
  @HiveField(0)
  final String bookId;
  @HiveField(1)
  final int amount;
  @HiveField(2)
  final int price;

  AddToCartModel({
    required this.bookId,
    required this.amount,
    required this.price,
  });

  @override
  bool operator ==(covariant AddToCartModel other) {
    if (identical(this, other)) return true;

    return other.bookId == bookId &&
        other.amount == amount &&
        other.price == price;
  }

  @override
  int get hashCode => bookId.hashCode ^ amount.hashCode ^ price.hashCode;
}
