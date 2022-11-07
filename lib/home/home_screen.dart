import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/home/popular.dart';
import 'package:movies/home/trending.dart';
import 'package:movies/home/upcoming.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Movie Center'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          )
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Watchlist'),

        ],
      ),

      body: ListView(
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
      ),
    );
  }
}
