import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/services/wishlisht_controller.dart';
import 'package:movies/wishlist/wishlist_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'home/home_screen.dart';

void main() {
  runApp(MyApp());
  Get.put(WishlishController());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: 'Movie Center',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}