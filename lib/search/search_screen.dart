import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class SearchScreen extends StatelessWidget {

  final searchedMovies = [].obs;
  final searchText = ''.obs;

  final TextEditingController controller = TextEditingController();

  fetchMovie() async {
    final query = controller.text;
    if (query.isNotEmpty) {
      final api = 'https://api.themoviedb.org/3/search/movie?query=$query&api_key=5bd1835f1281fdaab84dced9cfe4860e&page=1';
      final response = await http.get(Uri.parse(api));
      final body = jsonDecode(response.body);
      final results = body['results'];
      searchedMovies.value = results;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          onChanged: (val) {
            searchText.value = val;
          },
          onSubmitted: (_) {
            fetchMovie();
          },
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          Obx(() {
            return Opacity(
              opacity: searchText.isNotEmpty ? 1 : 0.1,
              child: IconButton(
                onPressed: () {
                  controller.clear();
                },
                icon: Icon(Icons.clear),
              ),
            );
          })
        ],
      ),
      body: Obx(() {
        if (searchedMovies.isEmpty) {
          return Center(child: Text('Nothing to show'),);
        }
        return ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: searchedMovies.length,
          itemBuilder: (ctx, index) {

            final movie = searchedMovies[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${movie['poster_path']}'
                ),
              ),
              title: Text(movie['title'] ?? 'null'),
              subtitle: Text(movie['release_date'] ?? ''),
            );
          },
        );
      })
    );
  }
}