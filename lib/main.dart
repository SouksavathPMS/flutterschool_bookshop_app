import 'package:flutter/material.dart';
import 'package:flutterschool_bookshop_app/constants/constant_colors.dart';
import 'package:flutterschool_bookshop_app/pages/getting_start_page.dart';
import 'package:flutterschool_bookshop_app/services/local_database_service.dart';

void main() async {
  await LocalDatabaseService.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: ConstantColor.mainColor,
        fontFamily: "NotoSansLao",
        scaffoldBackgroundColor: ConstantColor.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: ConstantColor.white,
          elevation: 0,
        ),
      ),
      home: const GettingStartPage(),
    );
  }
}
