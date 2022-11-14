import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/home/popular.dart';
import 'package:movies/home/trending.dart';
import 'package:movies/home/upcoming.dart';
import 'package:movies/search/search_screen.dart';
import 'package:movies/wishlist/wishlist_screen.dart';

class HomeScreen extends StatelessWidget {

  final currentIndex = 0.obs;
  final lightTheme = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Movie Center'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(SearchScreen());
            },
            icon: const Icon(CupertinoIcons.search),
          )
        ],
      ),

      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          onTap: (index) {
            currentIndex.value = index;
          },
          currentIndex: currentIndex.value,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Watchlist'),
          ],
        );
      }),

      body: Obx(() {
        return IndexedStack(
          index: currentIndex.value,
          children: [
            buildHomeContent(),
            WishlistScreen(),
          ],
        );
      }),
    );
  }

  buildHomeContent() {
    return ListView(
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Trending Now', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 18),
        Trending(),

        const SizedBox(height: 24),

        const Text('Upcoming Movies', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 18),
        const Upcoming(),

        const SizedBox(height: 24),

        const Text('Popular Movies', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 18),
        const Popular()
      ],
    );
  }
}
