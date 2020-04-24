import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarim_orman_ebook/pages/homePage.dart';
import 'locator.dart';
void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays ([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

