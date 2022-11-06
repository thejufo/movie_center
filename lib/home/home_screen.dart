import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/home/trending.dart';

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

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Trending Now', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 18),
          Trending()
        ],
      ),
    );
  }
}
