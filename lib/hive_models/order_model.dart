// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'order_model.g.dart';

@HiveType(typeId: 3)
class OrderModel {
  @HiveField(0)
  final String bookId;
  @HiveField(1)
  final int price;
  @HiveField(3)
  final int amount;
  @HiveField(4)
  final DateTime orderDate;

  OrderModel({
    required this.bookId,
    required this.price,
    required this.amount,
    required this.orderDate,
  });

  @override
  String toString() {
    return 'OrderModel(bookId: $bookId, price: $price, amount: $amount, orderDate: $orderDate)';
  }
}
