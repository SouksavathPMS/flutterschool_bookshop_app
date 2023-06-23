import 'package:flutterschool_bookshop_app/constants/enums.dart';
import 'package:flutterschool_bookshop_app/models/booktype_model_test.dart';
import 'package:rxdart/rxdart.dart';

class BookBloc {
  final Stream<TypeOfBooks?> currentType;
  final Stream<Iterable<BookTypeModelTest>> books;
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
    required Iterable<BookTypeModelTest> books,
  }) {
    final typeOfBook = BehaviorSubject<TypeOfBooks?>();
    final filteredBooks =
        typeOfBook.map<Iterable<BookTypeModelTest>>((typeOfBook) {
      if (typeOfBook != null) {
        if (typeOfBook == TypeOfBooks.all) {
          return books;
        } else {
          return books.where((element) => element.bookType == typeOfBook);
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
