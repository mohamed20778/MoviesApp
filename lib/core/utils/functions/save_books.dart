import 'package:hive/hive.dart';
import 'package:movies_app/models/movie_model.dart';

void saveBoxData(List<MovieModel> movieList, String boxname) {
  var movieBox = Hive.box(boxname);
  movieBox.addAll(movieList);
}
