import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/models/movie_model.dart';

void saveBoxData(List<MovieModel> movieList, String boxName) {
  try {
    final box = Hive.box<MovieModel>(boxName); // Get already opened box
    box.clear(); // Clear existing data
    box.addAll(movieList); // Add new data
  } catch (e) {
    if (kDebugMode) {
      print("Error saving to Hive: $e");
    }
  }
}
