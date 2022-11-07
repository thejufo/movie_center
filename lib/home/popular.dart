import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {

  Future<List> fetchPopular() async {
    const url = 'https://api.themoviedb.org/3/movie/popular?page=1&api_key=5bd1835f1281fdaab84dced9cfe4860e';
    final response = await http.get(Uri.parse(url));
    final body = jsonDecode(response.body);
    List results = body['results'];
    return results.sublist(0, 20);
  }

  @override
  void initState() {
    super.initState();
    fetchPopular();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPopular(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return buildGrid(snapshot.requireData);
        } else if (snapshot.hasError) {
          return Text('Error');
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  buildGrid(List upcoming) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: upcoming.length,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1/1.6,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12
      ),
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
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(movie['title']),
          ],
        );
      },
    );
  }
}
