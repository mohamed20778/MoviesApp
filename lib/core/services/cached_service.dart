import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/core/utils/constants.dart';
import 'package:movies_app/models/movie_model.dart';

class CachedService {
  static List<MovieModel> getCachedMovies() {
    if (kDebugMode) {
      print("Reading from cache...");
    }
    var movieBox = Hive.box<MovieModel>(ApiConstants.kmovieBox);
    return movieBox.values.toList();
  }
}
