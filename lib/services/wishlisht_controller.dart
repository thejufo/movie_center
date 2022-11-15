import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class WishlishController extends GetxController {

  final wishlistMovies = [];

  WishlishController({required this.db}) {
    const query = 'Select * From movies';

    db.rawQuery(query).then((movies) {
      wishlistMovies.addAll(movies);
      refresh();
    });
  }

  final Database db;

  addMovie(Map movie) {
    wishlistMovies.add(movie);

    final title = movie['title'];
    final image = 'https://image.tmdb.org/t/p/w500/${movie['poster_path']}';

    final sql = 'insert into movies (title, image) values("$title", "$image")';
    db.rawInsert(sql);

    refresh();
  }

  removeMovie(Map movie) {
    wishlistMovies.remove(movie);
    final sql = 'Delete from movies Where title = "${movie['title']}"';
    db.rawDelete(sql);
    refresh();
  }
}