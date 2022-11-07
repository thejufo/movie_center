import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Upcoming extends StatefulWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {

  Future<List> fetchUpcoming() async {
    const url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=5bd1835f1281fdaab84dced9cfe4860e&language=en-US';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    List results = body['results'];
    return results.sublist(0, 20);
  }

  @override
  void initState() {
    super.initState();
    fetchUpcoming();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUpcoming(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return buildList(snapshot.requireData);
        } else if (snapshot.hasError) {
          return Text('Error');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  buildList(List upcoming) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: upcoming.length,
        separatorBuilder: (ctx, index) => const SizedBox(width: 16),
        itemBuilder: (ctx, index) {

          Map movie = upcoming[index];
          String imageUrl =
              'https://image.tmdb.org/t/p/w500/${movie['poster_path']}';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(movie['title']),
            ],
          );
        },
      ),
    );
  }
}
