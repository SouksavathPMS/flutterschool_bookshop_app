import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';
import 'package:flutterschool_bookshop_app/constants/constant_font_size.dart';
import 'package:flutterschool_bookshop_app/notifier/page_notifier.dart';
import 'package:provider/provider.dart';

import '../blocs/search_bloc.dart';
import '../constants/dummy_data.dart';
import '../models/book_model.dart';
import 'custom_cart_badge.dart';

class GetAppBar {
  static final GetAppBar instance = GetAppBar._internal();
  factory GetAppBar() {
    return instance;
  }
  GetAppBar._internal();

  PreferredSize getAppbar({required int currentPage}) {
    final SearchBloc searchBloc = SearchBloc(
        books: DummyData.booksList
            .map((item) => BookModel.fromJson(item))
            .toList());

    final formKey = GlobalKey<FormBuilderState>();

    switch (currentPage) {
      case 0:
        return PreferredSize(
          preferredSize:
              const Size.fromHeight(126.0), // here the desired height
          child: AppBar(
            toolbarHeight: double.infinity,
            centerTitle: false,
            title: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ສະບາຍດີ",
                          style: TextStyle(
                            color: ConstantColor.primaryColor,
                            fontSize: ConstantFontSize.headerSizeBig,
                          ),
                        ),
                        Text(
                          "ມີປື້ມທີ່ທ່ານສົນໃຈໃນໃຈທ່ານ ຫຼື ຍັງ?",
                          style: TextStyle(
                            color: ConstantColor.grey,
                            fontSize: ConstantFontSize.headerSize3,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: 4)
                      ],
                    ),
                    CustomCartBadge()
                  ],
                ),
                const SizedBox(height: 8),
                SearchField(formKey: formKey, searchBloc: searchBloc),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      case 1:
        return PreferredSize(
          preferredSize: const Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            centerTitle: false,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ໝວດໝູ່",
                  style: TextStyle(
                    color: ConstantColor.darkGrey,
                    fontSize: ConstantFontSize.headerSizeBig,
                  ),
                ),
                CustomCartBadge()
              ],
            ),
          ),
        );
      case 2:
        return PreferredSize(
          preferredSize: const Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            centerTitle: false,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ປື້ມທີ່ມັກ",
                  style: TextStyle(
                    color: ConstantColor.darkGrey,
                    fontSize: ConstantFontSize.headerSizeBig,
                  ),
                ),
                CustomCartBadge()
              ],
            ),
          ),
        );
      case 3:
        return PreferredSize(
          preferredSize: const Size.fromHeight(70),
          // here the desired height
          child: AppBar(
            toolbarHeight: 68,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ConstantColor.darkGrey.withOpacity(.3),
                        blurRadius: 6,
                        spreadRadius: 0,
                        offset: const Offset(0, .05), // Shadow position
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        AssetImage("assets/images/user_avatar.png"),
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 12),
                    Text(
                      "ລາຍການສັ່ງຊື້",
                      style: TextStyle(
                        color: ConstantColor.darkGrey,
                        fontSize: ConstantFontSize.headerSizeBig,
                      ),
                    ),
                    Text(
                      "ກຳລັງສັ່ງຊື້ & ສັ່ງຊື້ສຳເລັດ",
                      style: TextStyle(
                        color: ConstantColor.grey,
                        fontSize: ConstantFontSize.headerSize3,
                        height: 1.0,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
                const Spacer(),
                const CustomCartBadge()
              ],
            ),
          ),
        );
      default:
        return PreferredSize(
            preferredSize:
                const Size.fromHeight(50.0), // here the desired height
            child: AppBar());
    }
  }
}

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.formKey,
    required this.searchBloc,
  });

  final GlobalKey<FormBuilderState> formKey;
  final SearchBloc searchBloc;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: FormBuilderTextField(
        onChanged: context.read<PageNotifier>().searchBloc.searchTerm.add,
        cursorColor: ConstantColor.grey,
        style: const TextStyle(color: ConstantColor.grey),
        decoration: InputDecoration(
          hintText: "ຄົ້ນຫາປື້ມ",
          hintStyle: TextStyle(color: ConstantColor.grey.withOpacity(.3)),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 24,
          ),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 30, minWidth: 40),
          isDense: true,
          filled: true,
          hoverColor: Colors.blue.shade100,
          contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        name: 'text',
      ),
    );
  }
}
