import 'package:flutter/material.dart';
import 'pages/homepage.dart';
// import 'pages/case1.dart';
// import 'pages/case2.dart';
// import 'pages/case3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        // HomePage.routeName: (context) => const HomePage(),
        // RekapPage.routeName: (context) => RekapPage(),
        // RekapPage.routeName: (context) => RekapPage(),
      },
    );
  }
}