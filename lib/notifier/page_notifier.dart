import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/blocs/search_bloc.dart';

import '../constants/dummy_data.dart';
import '../models/book_model.dart';
import '../screens/category_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/home_screen.dart';
import '../screens/user_screen.dart';

class PageNotifier extends ChangeNotifier {
  int _currentIndex = 0;
  get currentIndex => _currentIndex;
  get currentScreen => _currentScreen;

  void changePage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  final List<Widget> _currentScreen = [
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const UserScreen(),
  ];

  final _searchBloc = SearchBloc(
      books:
          DummyData.booksList.map((item) => BookModel.fromJson(item)).toList());
  SearchBloc get searchBloc => _searchBloc;
  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }
}
