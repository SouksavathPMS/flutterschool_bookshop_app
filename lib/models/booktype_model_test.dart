// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutterschool_bookshop_app/constants/enums.dart';

class BookTypeModelTest {
  final String name;
  final TypeOfBooks bookType;
  BookTypeModelTest({
    required this.name,
    required this.bookType,
  });

  factory BookTypeModelTest.fromMap(Map<String, dynamic> map) {
    return BookTypeModelTest(
      name: map['name'] as String,
      bookType: getBookType(map['type']),
    );
  }

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

  factory BookTypeModelTest.fromJson(String source) =>
      BookTypeModelTest.fromMap(json.decode(source) as Map<String, dynamic>);
}
