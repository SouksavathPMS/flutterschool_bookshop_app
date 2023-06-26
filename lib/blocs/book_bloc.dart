import 'package:flutterschool_bookshop_app/constants/enums.dart';
import 'package:flutterschool_bookshop_app/models/book_model.dart';
import 'package:rxdart/rxdart.dart';

class BookBloc {
  final Stream<TypeOfBooks?> currentType;
  final Stream<Iterable<BookModel>> books;
  final Sink<TypeOfBooks?> setTypeOfBook;

  const BookBloc._({
    required this.currentType,
    required this.setTypeOfBook,
    required this.books,
  });

  void dispose() {
    setTypeOfBook.close();
  }

  factory BookBloc({
    required Iterable<BookModel> books,
  }) {
    final typeOfBook = BehaviorSubject<TypeOfBooks?>();
    final filteredBooks = typeOfBook.map<Iterable<BookModel>>((typeOfBook) {
      if (typeOfBook != null) {
        if (typeOfBook == TypeOfBooks.all) {
          return books;
        } else {
          return books.where((element) => element.category == typeOfBook);
        }
      } else {
        return books;
      }
    }).startWith(books);

    return BookBloc._(
      currentType: typeOfBook.stream,
      setTypeOfBook: typeOfBook,
      books: filteredBooks,
    );
  }
}
