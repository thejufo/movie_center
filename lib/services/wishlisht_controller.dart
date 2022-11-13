import 'package:get/get.dart';

class WishlishController extends GetxController {

  final wishlistMovies = [];

  addMovie(Map movie) {
    wishlistMovies.add(movie);
    refresh();
  }

  removeMovie(Map movie) {
    wishlistMovies.remove(movie);
    refresh();
  }
}