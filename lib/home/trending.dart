import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class Trending extends StatefulWidget {
  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  RxList trending = [].obs;

  final activeDot = 0.obs;

  final controller = PageController();

  fetchTrending() async {
    const url =
        'https://api.themoviedb.org/3/trending/movie/day?api_key=5bd1835f1281fdaab84dced9cfe4860e';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    List results = body['results'];
    trending.value = results.sublist(0, 4);
  }

  @override
  void initState() {
    super.initState();
    fetchTrending();

    controller.addListener(() {
      activeDot.value = controller.page!.toInt();
    });

    Timer.periodic(Duration(seconds: 3), (timer) {
      final currentPage = controller.page!.toInt();
      print('Current page ${currentPage}');
      if (currentPage == 3) {
        controller.animateToPage(0, duration: Duration(seconds: 1), curve: Curves.linear);
      } else {
        controller.animateToPage(currentPage + 1, duration: Duration(seconds: 1), curve: Curves.linear);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: controller,
              itemCount: trending.value.length,
              itemBuilder: (ctx, index) {
                Map movie = trending.value[index];
                String imageUrl =
                    'https://image.tmdb.org/t/p/w500/${movie['backdrop_path']}';
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black87
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          movie['title'],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < trending.length; i++)
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration:  BoxDecoration(
                      color: i == activeDot.value ? Colors.red : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            );
          })
        ],
      );
    });
  }
}
