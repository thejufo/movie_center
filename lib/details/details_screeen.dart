import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:movies/services/wishlisht_controller.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({required this.movie, required this.image});

  final Map movie;
  final String image;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final cast = [].obs;



  void fetchCast() async {
    final id = widget.movie['id'];
    final url =
        'https://api.themoviedb.org/3/movie/$id/credits?page=1&api_key=5bd1835f1281fdaab84dced9cfe4860e';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    final result = body['cast'];
    cast.value = result;
  }

  @override
  void initState() {
    super.initState();
    fetchCast();
  }

  int exchageRate = 7600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.network(widget.image),
                Positioned(
                  bottom: -24,
                  right: 24,
                  child: GetBuilder(
                    init: Get.find<WishlishController>(),
                    builder: (ctrl) {
                      return FloatingActionButton(
                        onPressed: () {
                          if (ctrl.wishlistMovies.contains(widget.movie)) {
                            ctrl.removeMovie(widget.movie);
                          } else {
                            ctrl.addMovie(widget.movie);
                          }
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: ctrl.wishlistMovies.contains(widget.movie) ? Colors.red : Colors.grey,
                        child: Icon(Icons.favorite),
                      );
                    },
                  )
                ),
              ],
            ),
            SizedBox(height: 38),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                widget.movie['title'],
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                widget.movie['overview'],
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 38),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Cast',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 24),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Obx(() {
                  return Wrap(
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      for (final item in cast) buildCastItem(item),
                    ],
                  );
                }))
          ],
        ),
      ),
    );
  }

  buildCastItem(Map item) {
    String imageUrl = 'https://image.tmdb.org/t/p/w500/${item['profile_path']}';
    return Container(
      width: 90,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(height: 8),
          Text(
            item['name'],
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
