import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class WishlishController extends GetxController {

  WishlishController() {
    setup();
  }

  final wishlistMovies = [];

  late Database myDatabase;

  void setup() async {
    final location = await getDatabasesPath();
    final file = 'movie.db';
    final databasePath = location + '/' + file;
    myDatabase = await openDatabase(databasePath, version: 1, onCreate: (Database db, v) {
      const  sql = 'Create Table movies (id int primary key autoincrement, title text, image text)';
      db.execute(sql);
    });

    const query = 'Select * From movies';

    List movies = await myDatabase.rawQuery(query);
    wishlistMovies.addAll(movies);
    refresh();
  }

  @override
  void onInit() {
    // setup();
  }

  addMovie(Map movie) {
    wishlistMovies.add(movie);

    final title = movie['title'];
    final image = 'https://image.tmdb.org/t/p/w500/${movie['poster_path']}';

    final sql = 'insert into movies (title, image) values("$title", "$image")';
    myDatabase.rawInsert(sql);

    refresh();
  }

  removeMovie(Map movie) {
    wishlistMovies.remove(movie);
    refresh();
  }
}