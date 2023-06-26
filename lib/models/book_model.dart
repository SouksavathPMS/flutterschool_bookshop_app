// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

import '../constants/enums.dart';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  final String id;
  final String title;
  final TypeOfBooks category;
  final String imageUrl;
  final int price;
  final String author;
  final int rating;
  final String description;
  final String smallDetail;
  final bool isRecommended;

  BookModel({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.author,
    required this.rating,
    required this.description,
    required this.smallDetail,
    required this.isRecommended,
  });

  static TypeOfBooks getBookType(int type) {
    switch (type) {
      case 1:
        return TypeOfBooks.knowledge;
      case 2:
        return TypeOfBooks.history;
      case 3:
        return TypeOfBooks.law;
      case 4:
        return TypeOfBooks.relax;
      default:
        return TypeOfBooks.knowledge;
    }
  }

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        title: json["title"],
        category: getBookType(json['category']),
        imageUrl: json["imageUrl"],
        price: json["price"],
        author: json["author"],
        rating: json["rating"],
        description: json["description"],
        smallDetail: json["small_detail"],
        isRecommended: json["is_recommended"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "category": category,
        "imageUrl": imageUrl,
        "price": price,
        "author": author,
        "rating": rating,
        "description": description,
        "small_detail": smallDetail,
        "is_recommended": isRecommended,
      };
}
