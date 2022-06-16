import 'package:flutter/material.dart';
import 'package:teste_api/view/search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      title: 'Home',
      home: SearchPage(),
    );
  }
}
