import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../models/book_model.dart';

@immutable
class SearchBloc {
  final Stream<Iterable<BookModel>?> searchBooks;
  final Sink<String?> searchTerm;

  void dispose() {
    searchTerm.close();
  }

  const SearchBloc._({
    required this.searchBooks,
    required this.searchTerm,
  });

  factory SearchBloc({required Iterable<BookModel> books}) {
    final searchChange = BehaviorSubject<String?>();

    final results = searchChange
        .distinct()
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap<Iterable<BookModel>?>((searchTerm) {
      if (searchTerm == null || searchTerm.toString().trim().isEmpty) {
        return Stream<Iterable<BookModel>?>.value(null);
      } else {
        return Rx.fromCallable(() => books
            .where((element) =>
                element.title
                    .toLowerCase()
                    .contains(searchTerm.trim().toLowerCase()) ||
                element.author
                    .toLowerCase()
                    .contains(searchTerm.trim().toLowerCase()))
            .toList());
      }
    });

    return SearchBloc._(
      searchBooks: results.asBroadcastStream(),
      searchTerm: searchChange.sink,
    );
  }
}
