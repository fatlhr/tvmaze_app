import 'package:flutter/material.dart';

import 'pages/detail_page.dart';
import 'pages/home_page.dart';
import 'pages/ongoing_page.dart';
import 'pages/search_page.dart';
import 'pages/watchlists_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
