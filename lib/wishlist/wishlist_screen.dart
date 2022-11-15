import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/services/wishlisht_controller.dart';

class WishlistScreen extends StatefulWidget {
  WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<WishlishController>(),
      builder: (ctl) {

        if (ctl.wishlistMovies.isEmpty) {
          return Center(child: Text('Nothing to show'));
        }
        return ListView.builder(
          itemCount: ctl.wishlistMovies.length,
          itemBuilder: (ctx, index) {

            final movie = ctl.wishlistMovies[index];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${movie['poster_path']}'
                ),
              ),
              title: Text(movie['title'] ?? 'null'),
              subtitle: Text(movie['release_date'] ?? ''),
              trailing: ElevatedButton(
                onPressed: () => ctl.removeMovie(movie),
                child: Text('Remove'),
              ),
            );
          },
        );
      },
    );
  }
}
